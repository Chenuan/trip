//
//  LGJAnnotation.h
//  MapKit
//
//  Created by lanou on 15/7/1.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
//自定义大头针的类一定要遵守协议MKAnnotation
@interface LGJAnnotation : NSObject<MKAnnotation>

//协议里面的三个属性，重写的时候属性名不要写错
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

//为了标记每个标注视图（大头针）
@property (nonatomic) NSInteger tag;

@end
