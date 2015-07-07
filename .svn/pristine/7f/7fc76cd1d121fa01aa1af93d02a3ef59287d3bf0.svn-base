//
//  AsyNetworkTool.m
//  lesson UI16-网络封装
//
//  Created by lanou on 15/6/4.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "AsyNetworkTool.h"

//对于一些私有的属性或者方法，没必要.h接口文件中公开，尽力那个写在延展中，有主有代买的封装和别人的使用
@interface AsyNetworkTool ()
//用来接收数据的
@property (nonatomic, strong) NSMutableData *recrvieData;

@end
@implementation AsyNetworkTool


-(id)initWithUrlString:(NSString *)urlString
{
    if (self = [super init]) {
        //1.根据参数传递过来的url字符串创建一个url对象
        NSURL *url = [NSURL URLWithString:urlString];
        //2.根据url对象封装request请求对象
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.timeoutInterval = 60;
        //3.发送请求并设置代理
        [NSURLConnection connectionWithRequest:request delegate:self];
        
        
    }
    return self;
}
//异步请求类的协议方法的实现
#pragma -mark NSURLConnectionDataDelegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //1.初始化接收数据的data
    self.recrvieData = [[NSMutableData alloc]init];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{

    //2.拼接接收数据
    [self.recrvieData appendData:data];
  
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //解析数据
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:self.recrvieData options:NSJSONReadingMutableContainers error:nil];

    //判断代理是否存在并且判断相应代理方法
    if (self.delagate != nil &&[self.delagate respondsToSelector:@selector(asyResult:)]) {
        [self.delagate asyResult:dic];
     
        
    }
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%s===%d%@",__FUNCTION__,__LINE__,[error localizedDescription]);
    NSDictionary *dic = nil;
    if (self.delagate != nil &&[self.delagate respondsToSelector:@selector(asyResult:)]) {
        [self.delagate asyResult:dic];
        
        
    }

}

@end
