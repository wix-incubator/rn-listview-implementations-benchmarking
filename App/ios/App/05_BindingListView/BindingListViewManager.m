//
//  BindingListViewManager.m
//  App
//
//  Created by Sergey Ilyevsky on 23/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <React/RCTViewManager.h>
#import "BindingListView.h"

@interface BindingListViewManager : RCTViewManager

@end

@implementation BindingListViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
    return [[BindingListView alloc] initWithBridge:self.bridge];
}

RCT_EXPORT_VIEW_PROPERTY(rowHeight, float)
RCT_EXPORT_VIEW_PROPERTY(binding, NSDictionary)
RCT_EXPORT_VIEW_PROPERTY(rows, NSArray)

@end
