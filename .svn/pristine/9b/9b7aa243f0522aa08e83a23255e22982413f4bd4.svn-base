//
//  PhotosDataByCity.h
//  Trip1
//
//  Created by lanou on 15/6/24.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol photosDataByCityDelegate <NSObject>

-(void)getArrayByCityName:(NSMutableArray *)array;

@end


@interface PhotosDataByCity : NSObject
@property (nonatomic,assign) id<photosDataByCityDelegate> delegate;


-(void)getDataByCityName:(NSString *)cityName andPage:(int)page andModelID:(NSString *)ID;

+(void)getDataByCityName:(NSString *)cityName andPage:(int)page andModelID:(NSString *)ID arrayBlock:(void(^)(NSMutableArray *array))block;

@end
