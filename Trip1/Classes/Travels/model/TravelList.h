//
//  travelList.h
//  Trip1
//
//  Created by ccyy on 15/6/22.
//  Copyright © 2015年 kevin. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface TravelList : NSObject
@property (nonatomic,retain) NSString *name ;//： 游记名称
@property (nonatomic,assign) NSInteger date_added;//: 添加日期
@property (nonatomic,assign) NSInteger day_count ;//：天数
@property (nonatomic,assign) NSInteger waypoints ;//：足迹个数
@property (nonatomic,assign) NSInteger recommendations;//：喜欢人数
@property (nonatomic,retain) NSString *cover_image;//：图片
@property (nonatomic,assign) NSInteger id1;//：跳转到详细页面的ID

@property (nonatomic,retain) NSString *dateYMD;//年月日


@end
