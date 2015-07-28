//
//  City.m
//  Trip1
//
//  Created by ccyy on 15/7/2.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "City.h"

@implementation City

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


-(void)dealloc
{
    [_photo release ];
    [super dealloc];
}
@end
