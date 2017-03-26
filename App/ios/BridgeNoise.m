//
//  BridgeNoise.m
//  App
//
//  Created by Sergey Ilyevsky on 26/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTBridgeModule.h>

@interface BridgeNoise : NSObject <RCTBridgeModule>

@end

@implementation BridgeNoise {
    NSUInteger _chunksReceived;
    NSUInteger _chunksSent;
    NSUInteger _bytesReceived;
    NSUInteger _bytesSent;
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(reset_counters)
{
    _chunksReceived = 0;
    _chunksSent = 0;
    _bytesReceived = 0;
    _bytesSent = 0;
}

RCT_REMAP_METHOD(receiveAndSendData,
                 receiveString:(NSString *)stringIn
                 dateSent:(NSDate *)dateSent
                 lengthOfStringToSendBack:(NSUInteger)lengthOfStringToSendBack
                 callback:(RCTResponseSenderBlock)callback
                 )
{
    if(stringIn.length > 0) {
        _chunksReceived++;
        _bytesReceived += stringIn.length;
    }
    
    if(lengthOfStringToSendBack > 0) {
        NSString *stringOut = [self _randomStringOfLength:lengthOfStringToSendBack];
        _chunksSent++;
        _bytesSent += lengthOfStringToSendBack;
        callback(@[
                   stringOut,
                   [NSDate date],
                   @{
                       @"chunksReceived": @(_chunksReceived),
                       @"chunksSent": @(_chunksSent),
                       @"bytesReceived": @(_bytesReceived),
                       @"bytesSent": @(_bytesSent),
                   }]);
    }
}

- (NSString *)_randomStringOfLength:(NSUInteger)length
{
    static NSArray<NSString *> *stringBlocks;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stringBlocks = @
        [
         @"jfdshgkljhdasfgkljd hfgkljshd fkljghew85rhgkdsuifhgkdsjfhglkdjfhgkjdgfhkgdf",
         @"dsjfhr938hg fipwe8ugpiwerugyw4598yutpsiiftfkgdjshfgi8esyagfiausdfjhgk",
         @"udgifughs jlfdgh9834ytksdufjhklsdjfghslkdjfgkdufghsldui90384576ytieurhgkludrfhgkj",
         @"dirfuhgip8erybivpot8ey54iyhdroiusghoi845ygie85yuiopse5uygpios8e5uypigos5eugpoe",
         @"SJDFHGKLD854HTKLUJ940we80t9ue;zokgfdj ;o98U:OiHK:JHskfdj",
        ];
    });
    
    
    NSMutableArray<NSString *> *parts = @[].mutableCopy;
    while(length > 0) {
        int i = rand() % stringBlocks.count;
        NSString *part = stringBlocks[i];
        if(part.length > length) {
            part = [part substringToIndex:length];
        }
        length -= part.length;
        [parts addObject:part];
    }
    
    return [parts componentsJoinedByString:@""];
}

@end
