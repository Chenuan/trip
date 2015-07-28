//
//  DayLine.m
//  Trip1
//
//  Created by ccyy on 15/7/1.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "DayLine.h"

@implementation DayLine
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}



-(void)dealloc
{
    [_date release];
    [_name release];
    [super dealloc];
}
@end
