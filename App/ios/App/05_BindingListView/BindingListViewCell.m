//
//  BindingListViewCell.m
//  App
//
//  Created by Sergey Ilyevsky on 22/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "BindingListViewCell.h"

@implementation BindingListViewCell {
}

- (void)insertReactSubview:(UIView *)subview atIndex:(NSInteger)atIndex
{
    [self.contentView addSubview:subview];
}

@end
