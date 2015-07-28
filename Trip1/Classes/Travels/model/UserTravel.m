//
//  UserTravel.m
//  Trip1
//
//  Created by ccyy on 15/6/30.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "UserTravel.h"

@implementation UserTravel
-(void)dealloc
{
    [super dealloc];
    [_travelPhoto release];
    [_travelName release];
    
}

//-(void)setValue:(id)value forUndefinedKey:(NSString *)key
//{
//    if ([key isEqualToString:@"name"]) {
//        self.userName = value;
//        NSLog(@"key = %@,value = %@",key,value);
//    }
//    if ([key isEqualToString:@"avatar_l"]) {
//        self.headPhoto = value;
//    }
//    if ([key isEqualToString:@"cover"]) {
//        self.bgPhoto = value;
//    }
//}

@end
