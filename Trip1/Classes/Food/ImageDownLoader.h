//
//  ImageDownLoader.h
//  UI16练习
//
//  Created by lanou on 15/6/4.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//创建一个block用来传值使用
//这里用block传值比较直接方便 
//block使用参数来传值
typedef void(^result)(UIImage *);

@interface ImageDownLoader : NSObject
//声明一个接口
/*
 *参数一：用来传递，请求的URL
 *参数二：用传递，需要的Block
 */
+(void)imageDownloaderWithUrlString:(NSString *)urlString andResult:(result)result;

@end
