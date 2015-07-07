//
//  DetailTravel.h
//  Trip1
//
//  Created by ccyy on 15/6/23.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DetailTravel : NSObject


@property (nonatomic,retain) NSString *avatar_l;
@property (nonatomic,retain) NSString *city;
@property (nonatomic,assign) NSInteger mileage;

@property (nonatomic,retain ) UIImageView *headImageView;

@property (nonatomic,assign) NSInteger flight;
@property (nonatomic,assign) NSInteger hotel1;
@property (nonatomic,assign) NSInteger mall;
@property (nonatomic,assign) NSInteger sights;
@property (nonatomic,retain) NSString *trackpoints_thumbnail_image;

//tableCell里需要的数据
@property (nonatomic,assign) NSInteger comments;//
@property (nonatomic,retain) NSString *local_time;
@property (nonatomic,retain) NSString *photo;
@property (nonatomic,assign) CGFloat w;
@property (nonatomic,assign) CGFloat h;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,assign) NSInteger recommendations;//
@property (nonatomic,retain) NSString *text;



@end
