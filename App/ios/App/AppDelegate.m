/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

#import "RCCManager.h"
#import "UIViewOverrides.h"
#import "ViewsAnalyzer.h"

@implementation AppDelegate {
    ViewsAnalyzer *_viewsAnalyzer;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [UIViewOverrides class];
    
    NSURL *jsCodeLocation;
    
    jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [[RCCManager sharedInstance] initBridgeWithBundleURL:jsCodeLocation];
    
    _viewsAnalyzer = [[ViewsAnalyzer alloc] init];
    [_viewsAnalyzer addViewsObserver:self];
    
    return YES;
}

- (void)ViewAnalyzerObserver_visibleTopWrapperViewsAdded:(NSArray<WrapperView *> *)added removed:(NSArray<WrapperView *> *)removed
{
    NSLog(@"");
    NSLog(@"views removed: %@", removed);
    NSLog(@"views added: %@", added);
    NSLog(@"");
}


@end
