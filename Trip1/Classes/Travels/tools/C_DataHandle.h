//
//  C_DataHandle.h
//  Trip1
//
//  Created by ccyy on 15/6/22.
//  Copyright © 2015年 kevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class DetailTravel;
@interface C_DataHandle : NSObject
//游记列表页面的数据处理
+(NSMutableArray *)handleDictionary:(NSDictionary *)dic;

//游记详情页面静态数据的处理
+(DetailTravel *)dataWithDic:(NSDictionary *)dic;

//游记详情页面tableView需要的数据的处理
+(NSMutableArray *)headCellArrayWithDic:(NSDictionary *)dic;

#pragma -mark 小菊花
+(void)addView:(UIView *)aView HubToView:(UIView *)view;
+(void)hiddenHubAndView:(UIView *)aView ;

# pragma -mark 两个View间动画
+ (void)changeView:(UIView *)aView andView:(UIView *)bView inSuperView:(UIView *)superView;
+(void)addMBprogressHudToView:(UIView *)aView;

////保存行
//+(NSMutableArray *)cellArrayWithDic:(NSDictionary *)dic;
@end
