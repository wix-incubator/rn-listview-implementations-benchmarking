//
//  ViewsAnalyzer.h
//  App
//
//  Created by Sergey Ilyevsky on 14/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ViewsAnalyzer;
@class WrapperView;

@protocol ViewsAnalyzerObserver
- (void)ViewAnalyzerObserver_visibleTopWrapperViewsAdded:(NSArray<WrapperView *> *)added removed:(NSArray<WrapperView *> *)removed;
@end

@interface ViewsAnalyzer : NSObject

- (void)addViewsObserver:(id <ViewsAnalyzerObserver>)observer;
- (void)stopAnalyzing;

@end
