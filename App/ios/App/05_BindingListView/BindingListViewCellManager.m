//
//  BindingListViewCellManager.m
//  App
//
//  Created by Sergey Ilyevsky on 22/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <React/RCTViewManager.h>
#import "BindingListViewCell.h"

@interface BindingListViewCellManager : RCTViewManager

@end

@implementation BindingListViewCellManager

RCT_EXPORT_MODULE()

- (BindingListViewCell *)view
{
    return [[BindingListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
}

RCT_EXPORT_VIEW_PROPERTY(bindings, NSDictionary)

@end
