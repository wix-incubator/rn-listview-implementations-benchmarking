//
//  FullyNativeTableView.m
//  App
//
//  Created by Sergey Ilyevsky on 16/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "FullyNativeTableView.h"
#import "FullyNativeTableViewCell.h"

@implementation FullyNativeTableView {
    UITableView *_tableView;
}

- (instancetype)init
{
    if(self = [super init]) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor orangeColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        Class cellClass = [FullyNativeTableViewCell class];
        [_tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
        [self addSubview:_tableView];
}
    
    return self;
}

- (void)layoutSubviews
{
    _tableView.frame = self.frame;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)setData:(NSDictionary *)data
{
    _data = data;
    [_tableView reloadData];
}

- (NSArray *)_dataRows
{
    return self.data[@"rows"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 27;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self._dataRows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FullyNativeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FullyNativeTableViewCell class])];
    
    NSDictionary *dataItem = self._dataRows[indexPath.row];
    cell.image = [UIImage imageWithContentsOfFile:dataItem[@"img_path"]];
    cell.name = dataItem[@"name"];
    cell.index = dataItem[@"index"];
    
    return cell;
}

@end
