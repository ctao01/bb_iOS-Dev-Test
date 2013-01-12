//
//  CustomTableViewCell.m
//  Bottle Rocket iOS Developer Test
//
//  Created by Joy Tao on 1/11/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell ()

@end

@implementation CustomTableViewCell
@synthesize logoImageView = _logoImageView;
@synthesize phoneLabel = _phoneLabel;
@synthesize addressLabel = _addressLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGRect frame = self.contentView.frame;
        
        self.logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width/2, frame.size.height/2)];
        self.logoImageView.contentMode = UIViewContentModeTopLeft;
        
        
        self.phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 45.0f, frame.size.width/2, 40.0f)];

        CGRect phoneLabelFrame = self.phoneLabel.frame;
        self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(phoneLabelFrame.origin.x + phoneLabelFrame.size.width, phoneLabelFrame.origin.y, phoneLabelFrame.size.width, phoneLabelFrame.size.height)];
        self.addressLabel.numberOfLines = 0;
//        [self.addressLabel sizeToFit];
        
        [self.contentView addSubview:self.phoneLabel];
        [self.contentView addSubview:self.addressLabel];
        [self.contentView addSubview:self.logoImageView];
        
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self.phoneLabel sizeToFit];
    [self.addressLabel sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

- (void) dealloc
{
    [super dealloc];
    self.logoImageView = nil; [self.logoImageView release];
}




@end
