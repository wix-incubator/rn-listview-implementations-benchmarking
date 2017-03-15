//
//  IndexViewManager.m
//  App
//
//  Created by Sergey Ilyevsky on 14/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <React/RCTViewManager.h>
#import "WrapperView.h"

@interface WrapperViewManager : RCTViewManager

@end

@implementation WrapperViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [[WrapperView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(cellIndex, NSNumber)

@end
