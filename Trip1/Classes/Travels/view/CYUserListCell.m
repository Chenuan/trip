//
//  CYUserListCell.m
//  Trip1
//
//  Created by ccyy on 15/6/30.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "CYUserListCell.h"
#import "UIImageView+WebCache.h"

@implementation CYUserListCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setUser:(UserTravel *)user
{
    if (_user != user) {
        [_user release];
        _user = [user retain];
    }
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:user.travelPhoto]];
    self.travelName.text  = user.travelName;
}


- (void)dealloc {
    [_imageView1 release];
    [_travelName release];
    [super dealloc];
}
@end
