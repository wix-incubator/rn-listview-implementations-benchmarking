//
//  BindingListViewCell.h
//  App
//
//  Created by Sergey Ilyevsky on 22/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTView.h>

@interface BindingListViewCell : UITableViewCell

@property (nonatomic) NSDictionary<NSString*, NSDictionary*> *bindings;

@end
