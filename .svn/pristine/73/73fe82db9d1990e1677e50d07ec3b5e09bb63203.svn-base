//
//  CYbgCell.m
//  Trip1
//
//  Created by ccyy on 15/6/30.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "CYbgCell.h"
#define CYWidth [UIScreen mainScreen].bounds.size.width
#define CYHeight [UIScreen mainScreen].bounds.size.height

@implementation CYbgCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addAllViews];
    }
    return self;
    
}

-(void)addAllViews
{
    self.bgImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CYWidth, 250)]autorelease];
    [self.contentView addSubview:self.bgImageView];
 
    
    self.headImageView = [[[UIImageView alloc]initWithFrame:CGRectMake((self.contentView.frame.size.width-50)/2+25,20 , 50, 50)]autorelease];
    [self.contentView addSubview:self.headImageView];
    
    //使用UIView的属性layer做视图的改变
    //设置一个边框
    [self.headImageView.layer  setBorderWidth:1];
    //设置边框颜色
    [self.headImageView.layer setBorderColor:[UIColor clearColor].CGColor];
    //设置弧度半径
    [self.headImageView.layer setCornerRadius:25];
    
    //切掉边框以外的视图
     [self.headImageView.layer setMasksToBounds:YES];
    
    self.nameLabel = [[[UILabel alloc]initWithFrame:CGRectMake((CYWidth-200)/2, 70,200 , 30)]autorelease];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLabel];
   // self.nameLabel.backgroundColor = [UIColor whiteColor];
   
    
    self.bgImageView .alpha = 0.5;

    self.textLabel1 = [[[UILabel alloc]initWithFrame:CGRectMake(0, 250, CYWidth, 100)]autorelease];
    [self.contentView addSubview:self.textLabel1];
    self.textLabel1.numberOfLines = 0;
    
}

-(void)dealloc
{  [_textLabel1 release];
    [_bgImageView release];
    [_headImageView release];
    [_nameLabel release];
     [super dealloc];
}

@end
