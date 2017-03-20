//
//  AppTests.m
//  AppTests
//
//  Created by Sergey Ilyevsky on 15/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Scrollbot.h"
#import <EarlGrey/EarlGrey.h>

@interface AppTests : XCTestCase

@end

@implementation AppTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
  XCTestExpectation *expectation = [self expectationWithDescription:@"expectation"];
  
  [self scheduleSwipe];
  
  [self waitForExpectationsWithTimeout:3000.0 handler:^(NSError *error) {
    NSLog(@"some expectation error: %@", error);
  }];
  
//  sleep(100);
  
  NSLog(@"after expectation");
}

- (void)scheduleSwipe
{
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self scheduleSwipe];
    grey_execute_async(^{
      [[[ScrollBot alloc] init] trySwipeUp];
    });
  });
}

@end
