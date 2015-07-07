//
//  DomesticCity.m
//  MianBao
//
//  Created by lanou on 15/6/19.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "DomesticCity.h"

@implementation DomesticCity

-(void)dealloc
{
    [_cover release];
    [_cover_route_map_cover release];
    [_cover_s release];
    [_name_zh release];
    [_location release];
    [_visited_count release];
    [_wish_to_go_count release];
    [_url release];
    [_fullPath release];
    [super dealloc];
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"url"])  {
        self.url = [value stringByReplacingOccurrencesOfString:@"scenic" withString:@"place"];
    }
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(NSString *)fullPath
{
    if (_fullPath == nil) {
        _fullPath = [[kUrl stringByReplacingOccurrencesOfString:@"/index_places/8/" withString:self.url] retain];
    }
    return [[_fullPath retain] autorelease];
}

@end
