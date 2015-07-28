//
//  FoodListViewCell.h
//  Trip1
//
//  Created by lanou on 15/6/25.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FoodModel;
@interface FoodListViewCell : UITableViewCell
@property (nonatomic, retain) UILabel *foodListLabel;
@property (nonatomic, retain) UILabel *foodTitleLabel;
@property (nonatomic, retain) UIView *view;

@property (nonatomic, retain) FoodModel *model;
+(CGFloat) cellHight:(NSString *)listModel;
-(void)setViewHiden:(BOOL)hidden;
@end
