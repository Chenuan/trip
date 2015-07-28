//
//  FoodPicModel.m
//  Trip1
//
//  Created by lanou on 15/6/27.
//  Copyright © 2015年 kevin. All rights reserved.
//

#import "FoodPicModel.h"

@implementation FoodPicModel
-(void)dealloc
{
    [_photo_s release];
    [super dealloc];
}
-(void)setValue:( id)value forUndefinedKey:( NSString *)key
{
    
}

@end
