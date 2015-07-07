//
//  FoodModel.m
//  Trip1
//
//  Created by lanou on 15/6/22.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "FoodModel.h"

@implementation FoodModel
-(void)dealloc
{
    [_recommended release];
    [_tips_count release];
    [_name release];
    [_address release];
    [_cover_s release];
    [_mDescription release];
    [_category release];
    [_recommended_reason release];
    [_tel release];
    [_visited_count release];
    [_wish_to_go_count release];
    [_rating release];
    [_mID release];
    [super dealloc];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
  
}
-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"id"]) {
        self.mID =  [NSString stringWithFormat:@"%@",value] ;
        
    }
    if ([key isEqualToString:@"description"]) {
        self.mDescription = value;
    }
    if ([key isEqualToString:@"category"]) {
        self.category =  [NSString stringWithFormat:@"%@",value] ;
        
    }
    if ([key isEqualToString:@"rating"]) {
        self.rating =  [NSString stringWithFormat:@"%@",value] ;
        
    }
    if ([key isEqualToString:@"visited_count"]) {
        self.visited_count =  [NSString stringWithFormat:@"%@",value] ;
        
    }
    if ([key isEqualToString:@"wish_to_go_count"]) {
        self.wish_to_go_count =  [NSString stringWithFormat:@"%@",value] ;
        
    }
    if ([key isEqualToString:@"tips_count"]) {
        self.tips_count = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"recommended"]) {
        self.recommended = [NSString stringWithFormat:@"%@",value];
    }

    
}

@end
