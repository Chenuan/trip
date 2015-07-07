//
//  LGJTools.m
//  Trip1
//
//  Created by lanou on 15/6/22.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "LGJTools.h"


@implementation LGJTools

@end
@implementation NSString (UrlString)
+(NSData *)sendSynRequestGetDataByUrlString:(NSString *)urlString{
    //同步请求数据
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    //如果有错误，直接返回
    if (error) {
        NSLog(@"网络请求数据错误");
        return nil;
    }
    return data;
}

+(void)sendAsynRequestGetDataByUrlString:(NSString *)urlString data:(void(^)(NSData *data))block
{
    //同步请求数据
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //如果有错误，直接返回
        if (connectionError) {
            NSLog(@"网络请求数据错误");
            block(nil);
        }
        block(data);
    }];
}
@end
