//
//  travelListCell.m
//  Trip1
//
//  Created by ccyy on 15/6/22.
//  Copyright © 2015年 kevin. All rights reserved.
//

#import "TravelListCell.h"
#import "UIImageView+WebCache.h"
#import <UIKit/UIKit.h>
@interface TravelListCell ()
@property (retain, nonatomic) IBOutlet UIImageView *cover_imageView;
@property (retain, nonatomic) IBOutlet UILabel *likeLabel;

@property (retain, nonatomic) IBOutlet UILabel *daysLabel;
@property (retain, nonatomic) IBOutlet UILabel *footPointLabel;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation TravelListCell


- (void) layoutSubviews {
    [super layoutSubviews];
    self.backgroundView.frame = [UIScreen mainScreen].bounds;
    self.selectedBackgroundView.frame = [UIScreen mainScreen].bounds;
}

-(void)setTralist:(TravelList *)tralist
{
    if (_tralist != tralist) {
        [_tralist release];
        _tralist = [tralist retain];
    }
    self.titleLabel.text = tralist.name;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
   // NSLog(@"----%@",self.titleLabel.text);
   // NSLog(@"++++++%@",tralist.name);
    self.likeLabel.text = [NSString stringWithFormat:@"%lu人喜欢",tralist.recommendations];
    self.daysLabel.text = [NSString stringWithFormat:@"%lu天",tralist.day_count];
    self.footPointLabel.text = [NSString stringWithFormat:@"%lu足迹",tralist.waypoints];
    self.dateLabel.text = tralist.dateYMD;
    self.cover_imageView.layer.cornerRadius = 8;
    self.cover_imageView.layer.masksToBounds = YES;

    NSURL *url = [NSURL URLWithString:tralist.cover_image];
    [self.cover_imageView  sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place_location.png"]];
}

- (void)dealloc {
    [_cover_imageView release];
    [_likeLabel release];
    [_daysLabel release];
    [_footPointLabel release];
    [_dateLabel release];
    [_titleLabel release];
    
    [_tralist release];
    [super dealloc];
}
@end
