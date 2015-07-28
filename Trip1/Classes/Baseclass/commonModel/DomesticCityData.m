//
//  DomesticCityData.m
//  MianBao
//
//  Created by lanou on 15/6/19.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "DomesticCityData.h"
#import "Url.h"
#import "DomesticCity.h"
@implementation DomesticCityData
-(void)dealloc
{
    [_domesticCityDic release];
    [_domesticCityKeys release];
    [super dealloc];
}

static DomesticCityData *shareData = nil;
+(instancetype)shareInstance
{
    if (shareData == nil) {
        shareData = [[DomesticCityData alloc] init];
    }
    return shareData;
}

#pragma -mark 惰性初始化
-(NSMutableDictionary *)domesticCityDic{
    if (_domesticCityDic == nil) {
        
        [self loadingDomesticCityDic];
        
    }
    return [[_domesticCityDic retain] autorelease];
}
-(NSMutableArray *)domesticCityKeys{
    if (_domesticCityDic == nil) {
        [self loadingDomesticCityDic];
    }
    return [[_domesticCityKeys retain] autorelease];
}

#pragma -mark 网络读入数据
-(void)loadingDomesticCityDic{
    
    //同步请求数据
    NSURL *url = [NSURL URLWithString:kUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    //如果有错误，直接返回
    if (error) {
#warning -网络这里要进行优化
        NSLog(@"网络请求数据错误");
        NSLog(@"%@",error);
//        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"网络连接错误" message:@"请核实网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [aler show];
//        [aler release];

        
        return;
    }
    _domesticCityDic = [[NSMutableDictionary alloc] initWithCapacity:5];//初始化字典
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *tempArr = [dic objectForKey:@"data"];
    
    //模型化
    for (NSDictionary *dicTemp in tempArr) {
        DomesticCity *model = [[DomesticCity alloc] init];
        [model setValuesForKeysWithDictionary:dicTemp];

        [_domesticCityDic setValue:model forKey:model.name_zh];
        [model release];
    }
    
    //初始化keys
    _domesticCityKeys = [[NSMutableArray alloc] initWithArray:_domesticCityDic.allKeys];
}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0) {
//        [self loadingDomesticCityDic];
//        
//    }
//}
@end
