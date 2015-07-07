//
//  CYUserBgView.m
//  Trip1
//
//  Created by ccyy on 15/7/2.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "CYUserBgView.h"
#import "ShowBigPic.h"


@implementation CYUserBgView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;

}


-(void)addAllViews
{
    self.bgImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250)]autorelease];
    [self addSubview:self.bgImageView];
    
    
    self.headImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-50)/2,50 , 50, 50)]autorelease];
    [self addSubview:self.headImageView];
    
    //使用UIView的属性layer做视图的改变
    //设置一个边框
    [self.headImageView.layer  setBorderWidth:1];
    //设置边框颜色
    [self.headImageView.layer setBorderColor:[UIColor clearColor].CGColor];
    //设置弧度半径
    [self.headImageView.layer setCornerRadius:25];
    
    UITapGestureRecognizer *tap = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)]autorelease];
    [self.headImageView addGestureRecognizer:tap];
    self.headImageView.userInteractionEnabled  = YES;
    self.bgImageView . userInteractionEnabled = YES;
    
    
    //切掉边框以外的视图
    [self.headImageView.layer setMasksToBounds:YES];
    
    self.nameLabel = [[[UILabel alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-200)/2, 110,200 , 30)]autorelease];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.nameLabel];
    // self.nameLabel.backgroundColor = [UIColor whiteColor];
    
    
    self.bgImageView .alpha = 0.5;
    
    self.textLabel1 = [[[UILabel alloc]initWithFrame:CGRectMake(0, 250, [UIScreen mainScreen].bounds.size.width, 1)]autorelease];
    self.textLabel1.backgroundColor = [UIColor brownColor];
    [self addSubview:self.textLabel1];
    self.textLabel1.numberOfLines = 0;
    
}
-(void)tapAction
{
    [ShowBigPic showImage:self.headImageView];
}
-(void)dealloc
{  [_textLabel1 release];
    [_bgImageView release];
    [_headImageView release];
    [_nameLabel release];
    [super dealloc];
}

@end
