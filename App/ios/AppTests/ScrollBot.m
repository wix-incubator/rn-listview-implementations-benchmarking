//
// Created by Sergey Ilyevsky on 15/03/2017.
// Copyright (c) 2017 Facebook. All rights reserved.
//

#import "ScrollBot.h"
#import <EarlGrey/EarlGrey.h>


@implementation ScrollBot {

}

- (void)trySwipeUp
{
    id<GREYAction> swipeUp = [GREYActions actionForSwipeFastInDirection:kGREYDirectionUp];
    [swipeUp perform:[UIApplication sharedApplication].keyWindow error:nil];
}

@end
