//
//  FullyNativeTableView.h
//  App
//
//  Created by Sergey Ilyevsky on 16/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FullyNativeTableView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSDictionary *data;

@end
