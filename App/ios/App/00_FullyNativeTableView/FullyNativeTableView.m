//
//  FullyNativeTableView.m
//  App
//
//  Created by Sergey Ilyevsky on 16/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "FullyNativeTableView.h"

@implementation FullyNativeTableView {
    UITableView *_tableView;
}

- (instancetype)init
{
    if(self = [super init]) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor orangeColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self._dataRows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = self._dataRows[indexPath.row][@"name"];
    cell.backgroundColor = [UIColor cyanColor];
    
    return cell;
}

@end
