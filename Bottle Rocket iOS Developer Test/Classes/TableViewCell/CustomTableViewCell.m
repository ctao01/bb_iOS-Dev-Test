//
//  CustomTableViewCell.m
//  Bottle Rocket iOS Developer Test
//
//  Created by Joy Tao on 1/11/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "CustomTableViewCell.h"

#define OFFSET 10.0f

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
        
        self.logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 60.0f)];
        self.logoImageView.contentMode = UIViewContentModeScaleAspectFill | UIViewContentModeScaleAspectFit;
        self.logoImageView.frame = CGRectOffset(self.logoImageView.frame, 2.0f, 2.0f);
        
        self.phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width/2, 40.0f)];
        self.phoneLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];

        
        CGRect phoneLabelFrame = self.phoneLabel.frame;
        self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(phoneLabelFrame.origin.x + phoneLabelFrame.size.width, phoneLabelFrame.origin.y, phoneLabelFrame.size.width, phoneLabelFrame.size.height)];
        self.addressLabel.numberOfLines = 0;
        self.addressLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        
        [self.contentView addSubview:self.phoneLabel];
        [self.contentView addSubview:self.addressLabel];
        [self.contentView addSubview:self.logoImageView];
    }
    return self;
}

- (void) layoutSubviews
{

    [super layoutSubviews];

    CGSize imageSize = self.logoImageView.image.size;
    CGRect imageFrame = self.logoImageView.frame;
    
    self.logoImageView.frame = CGRectMake(imageFrame.origin.x, imageFrame.origin.y, imageFrame.size.width , imageSize.height);
    
    CGRect newImageFrame = self.logoImageView.frame;
    self.phoneLabel.frame = CGRectMake(newImageFrame.origin.x, newImageFrame.origin.y + newImageFrame.size.height, self.phoneLabel.frame.size.width, self.phoneLabel.frame.size.height);
    [self.phoneLabel sizeToFit];
    
    CGRect phoneLabelFrame = self.phoneLabel.frame;
    self.addressLabel.frame = CGRectMake(phoneLabelFrame.origin.x + phoneLabelFrame.size.width + OFFSET, phoneLabelFrame.origin.y, self.addressLabel.frame.size.width, self.addressLabel.frame.size.height);
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
    self.phoneLabel = nil; [self.phoneLabel release];
    self.addressLabel = nil; [self.addressLabel release];
}




@end
