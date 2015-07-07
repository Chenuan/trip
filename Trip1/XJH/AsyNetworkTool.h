//
//  AsyNetworkTool.h
//  lesson UI16-网络封装
//
//  Created by lanou on 15/6/4.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol AsyNetworkToolDelegata <NSObject>

-(void)asyResult:(id)result;

@end

@interface AsyNetworkTool : NSObject<NSURLConnectionDataDelegate>

//用来存放请求回来数据的属性
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic) BOOL isOnline;
@property (nonatomic, weak) id<AsyNetworkToolDelegata> delagate;

#pragma -mark 根据一个url创建一个异步初始化方法

-(id)initWithUrlString:(NSString *)urlString;

@end
