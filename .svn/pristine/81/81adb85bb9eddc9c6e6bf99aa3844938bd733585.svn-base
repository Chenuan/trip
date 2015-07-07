//
//  SceneModel.m
//  Trip1
//
//  Created by lanou on 15/6/22.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "SceneModel.h"

@implementation SceneModel

-(void)dealloc{
    [_tel release];
    [_address release];
    [_recommended_reason release];
    [_baseDescription release];
    [_arrival_type release];
    [_opening_time release];
    [_ID release];
    [_name release];
    [_name_en release];
    [_cover release];
    [_cover_route_map_cover release];
    [_cover_s release];
    [_city release];
    [super dealloc];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        self.baseDescription = value;
    }
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
