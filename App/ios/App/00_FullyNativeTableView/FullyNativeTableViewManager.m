//
//  FullyNativeTableViewManager.m
//  App
//
//  Created by Sergey Ilyevsky on 16/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <React/RCTViewManager.h>
#import "FullyNativeTableView.h"

@interface FullyNativeTableViewManager : RCTViewManager

@end

@implementation FullyNativeTableViewManager

RCT_EXPORT_MODULE()

RCT_EXPORT_VIEW_PROPERTY(data, NSDictionary)

- (UIView *)view
{
    return [[FullyNativeTableView alloc] init];
}

@end
