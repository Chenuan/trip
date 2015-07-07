//
//  ImageDownLoader.m
//  UI16练习
//
//  Created by lanou on 15/6/4.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "ImageDownLoader.h"

@implementation ImageDownLoader

+(void)imageDownloaderWithUrlString:(NSString *)urlString andResult:(result)result
{
    //对图片的网址进行二次异步处理
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //这里运用异步的Block模式 （这里运用block 方便 因为不需要管理图片加载过程中的各时间点）
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
#warning 如果网络出错，则直接传nil值，提醒：在网络错误的时候data是有数据的，所以不可以直接使用data，需进行判断
        if (connectionError != nil) {
            result(nil);
            return ;
        }
        //将请求回来的对她数据转化为UIImage类型并且传递出去
        UIImage *image = [UIImage imageWithData:data];
        //通过block的形式将数据传递出去
        result(image);
    }];
}
@end
