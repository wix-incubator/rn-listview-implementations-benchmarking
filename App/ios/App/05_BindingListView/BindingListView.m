//
//  BindingListView.m
//  App
//
//  Created by Sergey Ilyevsky on 22/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "BindingListView.h"
#import <React/RCTBridge.h>
#import <React/RCTUIManager.h>
#import "BindingListViewCell.h"

@interface RCTUIManager (BindingListView)
- (void)updateView:(NSNumber *)reactTag viewName:(NSString *)viewName props:(NSDictionary *)props;
@end

@implementation BindingListView {
    UITableView *_tableView;
    NSMutableArray *_unusedCells;
    RCTUIManager *_uiManager;
}

- (instancetype)initWithBridge:(RCTBridge *)bridge
{
    RCTAssertParam(bridge);
    
    if ((self = [super initWithFrame:CGRectZero]))
    {
        _uiManager = [self _retrieveUIManagerFromBridge:bridge];
        _unusedCells = [NSMutableArray array];

        _tableView = [self _createTableView];
        [self addSubview:_tableView];
    }
    
    return self;
}

- (void)insertReactSubview:(UIView *)subview atIndex:(NSInteger)atIndex
{
    [_unusedCells addObject:subview];
}

- (RCTUIManager *)_retrieveUIManagerFromBridge:(RCTBridge *)bridge
{
    while ([bridge respondsToSelector:NSSelectorFromString(@"parentBridge")]
           && [bridge valueForKey:@"parentBridge"])
    {
        bridge = [bridge valueForKey:@"parentBridge"];
    }
    
    return bridge.uiManager;
}

- (UITableView *)_createTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor orangeColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    return tableView;
}

- (void)layoutSubviews
{
    _tableView.frame = self.frame;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.rowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BindingListViewCell *cell = (BindingListViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell && _unusedCells.count > 0) {
        cell = [_unusedCells lastObject];
        [_unusedCells removeLastObject];
    }
    
    if(!cell) {
        RCTLogWarn(@"panic: no cells..");
        return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"polyfill"];
    }
    
    NSDictionary *row = [self.rows objectAtIndex:indexPath.row];
    
    for (NSString *bindingId in self.binding)
    {
        NSString *rowKey = [self.binding objectForKey:bindingId];
        NSDictionary *binding = [cell.bindings objectForKey:bindingId];
        if (!binding) continue;
        NSNumber *reactTag = [binding objectForKey:@"tag"];
        NSString *viewName = [binding objectForKey:@"viewName"];
        NSString *prop = [binding objectForKey:@"prop"];
        NSString *rowValue = [row objectForKey:rowKey];
        if ([prop isEqualToString:@"children"])
        {
            dispatch_async(RCTGetUIManagerQueue(), ^{
                [_uiManager updateView:reactTag viewName:@"RCTRawText" props:@{@"text": rowValue}];
                [_uiManager batchDidComplete];
            });
        }
        else
        {
            [_uiManager synchronouslyUpdateViewOnUIThread:reactTag viewName:viewName props:@{prop: rowValue}];
        }
    }
    
    return cell;
}

@end
