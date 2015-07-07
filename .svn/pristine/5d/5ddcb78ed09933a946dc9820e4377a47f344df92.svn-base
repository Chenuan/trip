//
//  FoodListViewCell.m
//  Trip1
//
//  Created by lanou on 15/6/25.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "FoodListViewCell.h"
#import "FoodModel.h"
#import "Masonry.h"

#define BS(blockSelf)  __block __typeof(&*self)blockSelf = self
#define FoodListWidth ([[UIScreen mainScreen] bounds].size.width-50)
#define FoodListHeight ([[UIScreen mainScreen] bounds].size.height-20)
@interface FoodListViewCell()
@property (nonatomic, retain) UILabel *mLabel;
@property (nonatomic, retain) UILabel *mLabel1;
@property (nonatomic, retain) UILabel *mLabel2;
@property (nonatomic, retain) UILabel *mLabel3;;


@end
@implementation FoodListViewCell
-(void)dealloc
{
    [_mLabel3 release];
    [_mLabel2 release];
    [_mLabel1 release];
    [_mLabel release];
    [_view release];
    [_foodTitleLabel release];
    [_foodListLabel release];
    [_model release];
    [super dealloc];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
     self.backgroundColor = [UIColor colorWithRed:251.0/255.0 green:244.0/255.0 blue:234.0/255.0 alpha:1];
    if (self) {
        BS(bs);
        //美化区域
        self.view = [[[UIView alloc]init] autorelease];
//        self.view.backgroundColor = [UIColor redColor];
        [bs.contentView addSubview:_view];
        [_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bs.contentView);
            make.size.mas_equalTo(CGSizeMake(FoodListWidth+50, 200));
            
        }];
        self.view.hidden = YES;
//        [_view release];
        
        self.mLabel = [[[UILabel alloc]init] autorelease];
//        self.mLabel.backgroundColor = [UIColor blueColor];
        [_view addSubview:_mLabel];
        [_mLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(50,50,120,50));
        }];
        self.mLabel.textAlignment = NSTextAlignmentCenter;
        self.mLabel.font = [UIFont systemFontOfSize:25];
//        [_mLabel release];
        
        self.mLabel1 = [[[UILabel alloc]init]autorelease];
//        self.mLabel1.backgroundColor = [UIColor greenColor];
        [_view addSubview:_mLabel1];
        [_mLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(100,50,80,50));
        }];
        self.mLabel1.textAlignment = NSTextAlignmentCenter;
        self.mLabel1.font = [UIFont systemFontOfSize:13];
//        [_mLabel1 release];
        
        
        self.mLabel2 = [[[UILabel alloc]init]autorelease];
//        self.mLabel2.backgroundColor = [UIColor blackColor];
        [_view addSubview:_mLabel2];
        [_mLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(170,50,20,50));
        }];
        self.mLabel2.textAlignment = NSTextAlignmentCenter;
        self.mLabel2.font = [UIFont systemFontOfSize:20];
//        [_mLabel2 release];
        
        self.mLabel3 = [[[UILabel alloc]init]autorelease];
//         self.imageV.backgroundColor = [UIColor blackColor];
        [_view addSubview:_mLabel3];
        [_mLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(130,50,50,50));
        }];
        self.mLabel3.textAlignment = NSTextAlignmentCenter;
        
//        [_mLabel3 release];
        
        
        //标题
        self.foodTitleLabel = [[[UILabel alloc]init] autorelease];
        [self. contentView addSubview:_foodTitleLabel];
//        self.foodTitleLabel.backgroundColor = [UIColor redColor];
        [_foodTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bs.contentView.mas_left).with.offset(20);
            make.top.equalTo(bs.contentView.mas_top).with.offset(10);
            make.width.equalTo(@(FoodListWidth));
            make.height.equalTo(@(20));
        
        }];
//        [_foodTitleLabel release];
        
        //简介
        self.foodListLabel = [[[UILabel alloc]init] autorelease];
//        self.foodListLabel.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_foodListLabel];
        [_foodListLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bs.contentView.mas_left).with.offset(20);
            make.top.equalTo(self.foodTitleLabel.mas_top).with.offset(30);
            make.width.equalTo(@(FoodListWidth));
            
        }];
        
        self.foodListLabel.font = [UIFont systemFontOfSize:14];
        self.foodListLabel.numberOfLines = 0;
//        [_foodListLabel release];
     
    }
    return self;
}
#pragma -mark设置隐藏View的方法
-(void)setViewHiden:(BOOL)hidden
{
    self.view.hidden = hidden;
}

-(void)touchMe:(UIButton *)button
{
    NSLog(@"点击了");
   }
-(void)setModel:(FoodModel *)model
{
    if (_model != model) {
        [_model release];
        _model = [model retain];
        
        self.mLabel.text = model.name;
        if (model.recommended_reason == nil || [model.recommended_reason isEqualToString: @""]) {
             self.mLabel1.text = model.mDescription;
        }else
        {
             self.mLabel1.text = model.recommended_reason;
        }
       
        self.mLabel2.text = @"------基本信息------";
        switch ([model.rating intValue]) {
      
            case 0:
                self.mLabel3.text = @"❄️❄️❄️❄️❄️";
                break;
            case 1:
                self.mLabel3.text = @"🌟❄️❄️❄️❄️";
                break;
            case 2:
                self.mLabel3.text = @"🌟🌟❄️❄️❄️";
                break;
            case 3:
                self.mLabel3.text = @"🌟🌟🌟❄️❄️";
                break;
            case 4:
                self.mLabel3.text = @"🌟🌟🌟🌟❄️";
                break;
            case 5:
                self.mLabel3.text = @"🌟🌟🌟🌟🌟";
                break;
                
            default:
                break;
        }
        
    }
}
+(CGFloat) cellHight:(NSString *)listModel
{
    CGRect rect = [listModel boundingRectWithSize:CGSizeMake(FoodListWidth, 100000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil];
    
    return rect.size.height+20+30;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
