//
//  travelList.m
//  Trip1
//
//  Created by ccyy on 15/6/22.
//  Copyright © 2015年 kevin. All rights reserved.
//

#import "TravelList.h"

@implementation TravelList

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
 //   NSLog(@"%@",key);
    if ([key  isEqualToString: @"id"]) {
        [self setValue:value forKey:@"id1"];
    }
}

-(void)setDate_added:(NSInteger)date_added
{
    _date_added = date_added;
    NSDate *dt = [NSDate dateWithTimeIntervalSince1970:date_added];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy年MM月dd日"];
    NSString *str = [df stringFromDate:dt];
    [df release];
    self.dateYMD = str;
  //  NSLog(@"%@",self.dateYMD);
}

-(void)dealloc
{
    [_name release];
    [_cover_image release];
    [_dateYMD release];
    [super dealloc];

}
@end
