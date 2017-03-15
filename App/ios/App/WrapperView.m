//
//  WrapperView.m
//  App
//
//  Created by Sergey Ilyevsky on 14/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "WrapperView.h"

@implementation WrapperView {
}

- (void)layoutSubviews
{
//  NSLog(@"[WrapperView %@]", NSStringFromSelector(_cmd));
  [super layoutSubviews];
}

- (void)didMoveToSuperView
{
//  NSLog(@"[WrapperView %@]", NSStringFromSelector(_cmd));
  [super didMoveToSuperview];
}

- (void)didAddSubview:(UIView *)subview
{
//  NSLog(@"[WrapperView %@]", NSStringFromSelector(_cmd));
  [super didAddSubview:subview];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"WrapperView<cellIndex: %@, pointer: %p>", self.cellIndex, self];
}

@end
