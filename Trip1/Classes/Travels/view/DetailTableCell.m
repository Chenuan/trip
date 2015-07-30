//
//  DetailTableCell.m
//  Trip1
//
//  Created by ccyy on 15/6/24.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "DetailTableCell.h"
#import "DetailTravel.h"
//#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"
@interface DetailTableCell ()
//@property (retain, nonatomic) IBOutlet UILabel *dayLabel;
//@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
@property (retain, nonatomic) IBOutlet UIImageView *photoImageView;
@property (retain, nonatomic) IBOutlet UILabel *text_label;

@property (retain, nonatomic) IBOutlet UILabel *localTimeLabel;
@property (retain, nonatomic) IBOutlet UILabel *likeLabel;
@property (retain, nonatomic) IBOutlet UILabel *commentLabel;

@property (retain, nonatomic) IBOutlet NSLayoutConstraint *photoImageViewwidth;

@end

@implementation DetailTableCell



-(void)setDetailTra:(DetailTravel *)detailTra
{
    if (_detailTra != detailTra) {
        [_detailTra release];
        _detailTra = [detailTra retain];
    }
    self.text_label.text = detailTra.text;
    self.localTimeLabel.text = detailTra.local_time;
    self.likeLabel.text = [NSString stringWithFormat:@"%lu",detailTra.recommendations];
    self.commentLabel.text = [NSString stringWithFormat:@"%lu",detailTra.comments];
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString: detailTra.photo] placeholderImage:[UIImage imageNamed:@"place_location"] options:SDWebImageLowPriority  progress:^(NSInteger receivedSize, NSInteger expectedSize) {

    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.photoImageView.image = image;
    }];
    if ([detailTra.photo isEqualToString:@""]) {
        self.photoImageViewwidth.constant = 0;
    }else{
        self.photoImageViewwidth.constant = detailTra.h/detailTra.w*self.contentView.frame.size.width;
    }

}

- (void)dealloc {
    [_photoImageView release];
    [_text_label release];
    [_localTimeLabel release];
    [_likeLabel release];
    [_commentLabel release];
    [_photoImageViewwidth release];
    
    [_detailTra release];
    [_pic release];
    [super dealloc];
}
@end
