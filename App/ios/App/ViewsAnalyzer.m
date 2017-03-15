//
//  ViewsAnalyzer.m
//  App
//
//  Created by Sergey Ilyevsky on 14/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "ViewsAnalyzer.h"
#import "WrapperView.h"
#import <UIKit/UIKit.h>
#import <React/RCTDefines.h>

@implementation ViewsAnalyzer {
    BOOL _shouldStopAnalyzing;
    NSArray<WrapperView *> *_topVisibleWrapperViews;
    NSPointerArray *_observers;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _topVisibleWrapperViews = [self _findTopVisibleWrapperViews];
        _observers = [NSPointerArray pointerArrayWithOptions:NSPointerFunctionsWeakMemory];
        [self _scheduleNext];
    }
    
    return self;
}

- (void)_analyze
{
    NSArray<WrapperView *> *updatedViews = [self _findTopVisibleWrapperViews];
    
    NSMutableArray<WrapperView *> *addedViewsMutable = updatedViews.mutableCopy;
    [addedViewsMutable removeObjectsInArray:_topVisibleWrapperViews];
    NSArray<WrapperView *> *addedViews = addedViewsMutable.copy;
    
    NSMutableArray<WrapperView *> *removedViewsMutable = _topVisibleWrapperViews.mutableCopy;
    [removedViewsMutable removeObjectsInArray:updatedViews];
    NSArray<WrapperView *> *removedViews = removedViewsMutable.copy;
    
    _topVisibleWrapperViews = updatedViews;
    
    if(addedViews.count > 0 || removedViews.count > 0) {
        for(id<ViewsAnalyzerObserver> observer in _observers) {
            [observer ViewAnalyzerObserver_visibleTopWrapperViewsAdded:addedViews removed:removedViews];
        }
    }
    
    if(!_shouldStopAnalyzing) {
        [self _scheduleNext];
    }
}

- (void)_scheduleNext
{
    [self performSelector:@selector(_analyze)
               withObject:nil
               afterDelay:0.01
                  inModes:@[
                            NSDefaultRunLoopMode,
                            UITrackingRunLoopMode
                            ]
     ];
}

- (void)stopAnalyzing
{
    _shouldStopAnalyzing = YES;
}

- (void)addViewsObserver:(id<ViewsAnalyzerObserver>)observer
{
    [_observers addPointer:(__bridge void * _Nullable)(observer)];
}

- (void)_pushTopWrapperViewsUnderView:(UIView *)view toArray:(NSMutableArray<WrapperView *> *)wrapperViews
{
    for(UIView *subView in view.subviews) {
        if([subView isKindOfClass:[WrapperView class]]) {
            [wrapperViews addObject:(WrapperView *)subView];
            continue;
        }
        
        [self _pushTopWrapperViewsUnderView:subView toArray:wrapperViews];
    }
}

- (NSArray<WrapperView *> *)_findTopWrapperViews
{
    NSMutableArray *wrapperViews = @[].mutableCopy;
    [self _pushTopWrapperViewsUnderView:[UIApplication sharedApplication].keyWindow toArray:wrapperViews];
    return wrapperViews.copy;
}

- (NSArray<WrapperView *> *)_findTopVisibleWrapperViews
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    NSMutableArray *visibleViews = @[].mutableCopy;
    
    for(WrapperView *view in [self _findTopWrapperViews]) {
        CGRect viewFrame = [view.superview convertRect:view.frame toView:window];
        if(CGRectIntersectsRect(window.frame, viewFrame)) {
            [visibleViews addObject:view];
        }
    }
    
    return visibleViews.copy;
}

@end
