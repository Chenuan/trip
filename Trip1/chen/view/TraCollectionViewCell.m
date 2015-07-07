//
//  TraCollectionViewCell.m
//  Trip1
//
//  Created by ccyy on 15/6/29.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "TraCollectionViewCell.h"
#define XJHWidth ([[UIScreen mainScreen] bounds].size.width)
#define XJHHeight ([[UIScreen mainScreen] bounds].size.height - 64)

@implementation TraCollectionViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame
{
    self =  [super initWithFrame:frame];
    if (self) {
        self.image_view = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.height)]autorelease];
       // NSLog(@"%f",frame.size.width);
        self.image_view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.image_view];
    }
    return self;
    
}

-(void)dealloc
{
    [_image_view release];
    [super dealloc];
}

@end
