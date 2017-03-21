//
//  FullyNativeTableViewCell.m
//  App
//
//  Created by Sergey Ilyevsky on 20/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "FullyNativeTableViewCell.h"

@implementation FullyNativeTableViewCell {
    IBOutlet UIImageView *_imageView;
    IBOutlet UITextField *_nameTextField;
    IBOutlet UITextField *_indexTextField;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_imageView];

        _nameTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _nameTextField.textAlignment = NSTextAlignmentCenter;
        _nameTextField.font = [UIFont systemFontOfSize:14];
        _nameTextField.adjustsFontSizeToFitWidth = NO;
        [self.contentView addSubview:_nameTextField];

        _indexTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _indexTextField.textAlignment = NSTextAlignmentRight;
        _indexTextField.font = [UIFont fontWithName:@"Courier" size:14];
        [self.contentView addSubview:_indexTextField];
        
        self.contentView.backgroundColor = [UIColor cyanColor];
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat height = 25;
    CGFloat cellHeight = self.frame.size.height;
    CGFloat cellWidth = self.frame.size.width;
    CGFloat nameTextFieldWidth = self.frame.size.width * 0.7;
    CGFloat indexTextFieldWidth = self.frame.size.width * 0.15;
    CGFloat indexTextFieldRightMargin = 5;
    
    self.contentView.frame = CGRectMake(0, (cellHeight - height) / 2, cellWidth, height);
    
    _imageView.frame = CGRectMake(0, 0, height, height);
    
    _nameTextField.frame = CGRectMake((cellWidth - nameTextFieldWidth) / 2, 0, nameTextFieldWidth, height);
    
    _indexTextField.frame = CGRectMake(cellWidth - indexTextFieldWidth - indexTextFieldRightMargin, 0, indexTextFieldWidth, height);
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    _imageView.image = image;
}

- (void)setName:(NSString *)name
{
    _name = name;
    _nameTextField.text = name;
}

- (void)setIndex:(NSNumber *)index
{
    _index = index;
    _indexTextField.text = [NSString stringWithFormat:@"%@", index];
}

@end
