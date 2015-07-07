//
//  FoodPicCollectionViewCell.m
//  Trip1
//
//  Created by lanou on 15/6/27.
//  Copyright © 2015年 kevin. All rights reserved.
//

#import "FoodPicCollectionViewCell.h"
#define XJHWidth ([[UIScreen mainScreen] bounds].size.width)
#define XJHHeight ([[UIScreen mainScreen] bounds].size.height - 64)
#define BackgroundColor ([UIColor colorWithRed:251.0/255.0 green:244.0/255.0 blue:234.0/255.0 alpha:1])
@implementation FoodPicCollectionViewCell
-(void)dealloc
{
    [_imageview1 release];
    [super dealloc];
}
-(instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BackgroundColor;
        self.imageview1 = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (XJHWidth-8)/3,(XJHWidth-8)/3)] autorelease];
//       self.imageview1.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_imageview1];
        
        }
    return self;
    
}
@end
