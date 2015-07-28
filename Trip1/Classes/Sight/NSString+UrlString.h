//
//  NSString+UrlString.h
//  Trip1
//
//  Created by lanou on 15/6/22.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UrlString)

+(NSData *)sendSynRequestGetDataByUrlString:(NSString *)urlString;
+(void)sendAsynRequestGetDataByUrlString:(NSString *)urlString data:(void(^)(NSData *data))block;


+ (NSString *)URLEncodedString:(NSString *)urlString;

@end
