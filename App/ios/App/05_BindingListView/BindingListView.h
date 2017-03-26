//
//  BindingListView.h
//  App
//
//  Created by Sergey Ilyevsky on 22/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RCTBridge;

@interface BindingListView : UIView <UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithBridge:(RCTBridge *)bridge;

@property (nonatomic) float rowHeight;
@property (nonatomic) NSDictionary<NSString*, NSString*> *binding;
@property (nonatomic) NSArray *rows;

@end
