//
//  FoodTableViewCell.m
//  Trip1
//
//  Created by lanou on 15/6/22.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "FoodTableViewCell.h"
#import "FoodModel.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#define BS(blockSelf)  __block __typeof(&*self)blockSelf = self
#define BackgroundColor ([UIColor colorWithRed:251.0/255.0 green:244.0/255.0 blue:234.0/255.0 alpha:1])
@implementation FoodTableViewCell
- (void)dealloc
{
    NSLog(@"....cell");
    [_foodGoodImage release];
    [_foodRatingLabel release];
    [_foodTips_countLabel release];
    [_foodDescriptonLabel release];
    [_foodModel release];
    [_foodTitlLabel release];
    [_footImage release];
    [_foodVisited_count release];
    [super dealloc];
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = BackgroundColor;
        BS(bs);
        //图片位置
       int padding1 = 10;
        self.footImage = [[[UIImageView alloc]init] autorelease];
        self.footImage.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_footImage];
        [_footImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bs.mas_left).with.offset(padding1);
            make.top.equalTo(bs.mas_top).with.offset(padding1);
            make.height.mas_equalTo(@(100));
            make.width.equalTo(@(100));
        }];
        self.footImage.layer.masksToBounds = YES;
        self.footImage.layer.cornerRadius = 8;
        
        
//        [_footImage release];
        
        //推荐位置

        self.foodGoodImage = [[[UIImageView alloc]init] autorelease];
//        self.foodGoodImage.backgroundColor = [UIColor redColor];
        [_footImage addSubview:_foodGoodImage];
        [_foodGoodImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bs.mas_left).with.offset(padding1+8);
            make.top.equalTo(bs.mas_top).with.offset(padding1);
            make.height.mas_equalTo(@(20));
            make.width.equalTo(@(20));
        }];
//        [self.foodGoodImage release];
        
        
        //标题
        self.foodTitlLabel = [[[UILabel alloc]init] autorelease];
//        self.foodTitlLabel.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_foodTitlLabel];
        [_foodTitlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.footImage.mas_right).with.offset(padding1);
            make.top.equalTo(self.footImage.mas_top).with.offset(0);
            make.height.mas_equalTo(@(20));
            make.right.equalTo(bs.mas_right).with.offset(-10);;
        }];
        self.foodTitlLabel.font = [UIFont systemFontOfSize:18];
//        [_foodTitlLabel release];
        
        //简介
        self.foodDescriptonLabel = [[[UILabel alloc]init] autorelease];
//        self.foodDescriptonLabel.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_foodDescriptonLabel];
        [_foodDescriptonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.footImage.mas_right).with.offset(padding1);
            make.top.equalTo(self.footImage.mas_top).with.offset(35);
            make.height.mas_equalTo(@(10));
            make.right.equalTo(bs.mas_right).with.offset(-70);;

        }];
        self.foodDescriptonLabel.font = [UIFont systemFontOfSize:12];
        self.foodDescriptonLabel.numberOfLines = 1;
//        [_foodDescriptonLabel release];
        
        //评分
        self.foodRatingLabel = [[[UILabel alloc]init] autorelease];
//        self.foodRatingLabel.backgroundColor = [UIColor redColor];
        
        //        self.foodDescriptonLabel.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_foodRatingLabel];
        [_foodRatingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.footImage.mas_right).with.offset(padding1);
            make.top.equalTo(self.footImage.mas_top).with.offset(55);
            make.height.mas_equalTo(@(20));
            make.right.equalTo(bs.mas_right).with.offset(-10);;
            
        }];
        self.foodRatingLabel.font = [UIFont systemFontOfSize:12];
//        [_foodRatingLabel release];
        
        
        //评论
        self.foodTips_countLabel = [[[UILabel alloc]init] autorelease];
        //        self.foodDescriptonLabel.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_foodTips_countLabel];
        [_foodTips_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.footImage.mas_right).with.offset(100);
            make.top.equalTo(self.footImage.mas_top).with.offset(55);
            make.height.mas_equalTo(@(20));
            make.right.equalTo(bs.mas_right).with.offset(-10);;
            
        }];
        self.foodTips_countLabel.font = [UIFont systemFontOfSize:12];
//        [_foodTips_countLabel release];
        
        //来访客人
        self.foodVisited_count = [[[UILabel alloc]init] autorelease];
//        self.foodVisited_count.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_foodVisited_count];
        [_foodVisited_count mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.footImage.mas_right).with.offset(padding1);
            make.bottom.equalTo(self.footImage.mas_bottom).with.offset(0);
            make.height.mas_equalTo(@(15));
            make.right.equalTo(bs.mas_right).with.offset(-10);;
            
        }];
        self.foodVisited_count.font = [UIFont systemFontOfSize:10];
//        [_foodVisited_count release];
        
        
    }
    return self;
    
}
-(void)setViewHiden:(BOOL)hidden
{
    self.foodGoodImage.hidden = hidden;
    
}
-(void)setFoodModel:(FoodModel *)foodModel
{
    if (_foodModel !=foodModel) {
        [_foodModel release];
        _foodModel = [foodModel retain];
        
        self.foodTitlLabel.text = foodModel.name;
        
        if (foodModel.recommended_reason == nil ||[foodModel.recommended_reason isEqualToString:@""] ) {
             self.foodDescriptonLabel.text = foodModel.mDescription;
        }else{
            self.foodDescriptonLabel.text = foodModel.recommended_reason;
        }
        
        self.foodVisited_count.text = [foodModel.visited_count stringByAppendingString:@"人去过"];
        
        [self.footImage sd_setImageWithURL:[NSURL URLWithString:foodModel.cover_s]];

        
        
        int count =[foodModel.rating intValue];
        switch (count) {
                
            case 0:
                self.foodRatingLabel.text = @"❄️❄️❄️❄️❄️";
                break;
            case 1:
                self.foodRatingLabel.text = @"🌟❄️❄️❄️❄️";
                break;
            case 2:
                self.foodRatingLabel.text = @"🌟🌟❄️❄️❄️";
                break;
            case 3:
                self.foodRatingLabel.text = @"🌟🌟🌟❄️❄️";
                break;
            case 4:
                self.foodRatingLabel.text = @"🌟🌟🌟🌟❄️";
                break;
            case 5:
                self.foodRatingLabel.text = @"🌟🌟🌟🌟🌟";
                break;
                
            default:
                break;
        }
        self.foodTips_countLabel.text = [foodModel.tips_count stringByAppendingString:@"人评论"];
        
        if ([foodModel.recommended isEqualToString:@"1"]) {
             self.foodGoodImage.image = [UIImage imageNamed:@"iconfont-tuijian"];
        }
        
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
