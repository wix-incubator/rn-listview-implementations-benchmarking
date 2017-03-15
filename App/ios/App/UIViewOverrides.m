//
//  UIViewOverrides.m
//  App
//
//  Created by Sergey Ilyevsky on 14/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

@import UIKit;
@import ObjectiveC;
#import "UIViewOverrides.h"

static IMP origImp_didMoveToSuperview;

void replImp_didMoveToSuperview(UIView *target, SEL selector)
{
  NSLog(@"didMoveToSuperview:\n    target: %@\n    superview: %@\n\n\n", target, target.superview);
  ((void (*)(UIView *, SEL))origImp_didMoveToSuperview)(target, selector);
}

@implementation UIViewOverrides
+ (void)initialize
{
//  Method method_didMoveToSuperview = class_getInstanceMethod([UIView class], @selector(didMoveToSuperview));
//  origImp_didMoveToSuperview = method_getImplementation(method_didMoveToSuperview);
//  method_setImplementation(method_didMoveToSuperview, (IMP)replImp_didMoveToSuperview);
}
@end
