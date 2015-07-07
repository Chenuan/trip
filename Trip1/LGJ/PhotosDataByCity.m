//
//  PhotosDataByCity.m
//  Trip1
//
//  Created by lanou on 15/6/24.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "PhotosDataByCity.h"
#import "DomesticCity.h"
#import "DomesticCityData.h"
#import "LGJHeader.h"

@interface PhotosDataByCity()<NSURLConnectionDataDelegate>
@property (nonatomic,retain) NSURLConnection *conection;
@property (nonatomic,retain) NSMutableData *data;
@end

@implementation PhotosDataByCity
-(void)dealloc
{
    self.delegate = nil;
    [_conection cancel];
    [_conection release];
    [_data release];
    [super dealloc];
}

+(void)getDataByCityName:(NSString *)cityName andPage:(int)page andModelID:(NSString *)ID arrayBlock:(void(^)(NSMutableArray *array))block
{
    
    NSString *photosHead = [kUrl stringByReplacingOccurrencesOfString:@"/index_places/8/" withString:@"/place/5/"];
    NSString *scenePath = [NSString stringWithFormat:@"%@%@/photos/?sort=default&start=%d",photosHead,ID,page];

    
    [NSString sendAsynRequestGetDataByUrlString:scenePath data:^(NSData *data) {
        NSMutableArray *sightsArray = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
        if (data != nil) {
            NSError *error = nil;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error == nil) {
                NSArray *arr = [dic objectForKey:@"items"];
                for (NSDictionary *tempDic in arr) {
                    NSString *photoString = [tempDic objectForKey:@"photo_s"];
                    [sightsArray addObject:photoString];
                }

            }
        }
        block(sightsArray);
    }];

}
-(void)getDataByCityName:(NSString *)cityName andPage:(int)page andModelID:(NSString *)ID
{
    NSString *photosHead = [kUrl stringByReplacingOccurrencesOfString:@"/index_places/8/" withString:@"/place/5/"];
    NSString *scenePath = [NSString stringWithFormat:@"%@%@/photos/?sort=default&start=%d",photosHead,ID,page];
    
    
    [self sendAsynRequestGetDataByUrlString:scenePath];
}


-(void)sendAsynRequestGetDataByUrlString:(NSString *)urlString
{
    //同步请求数据
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    __block PhotosDataByCity *wSelf = self;
    
    NSURLConnection *conection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.conection = conection;
    [conection release];
    
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        //如果有错误，直接返回
//        if (connectionError) {
//            NSLog(@"网络请求数据错误");
//        }
//        if (wSelf.delegate != nil && [wSelf.delegate respondsToSelector:@selector(getArrayByCityName:)]) {
//            
//        }
//    }];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.data = [[[NSMutableData alloc] init] autorelease];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSMutableArray *sightsArray = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    if (self.data != nil) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:&error];
        if (error == nil) {
            NSArray *arr = [dic objectForKey:@"items"];
            for (NSDictionary *tempDic in arr) {
                NSString *photoString = [tempDic objectForKey:@"photo_s"];
                [sightsArray addObject:photoString];
            }
        }
    }
    
    [self.delegate getArrayByCityName:sightsArray];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"网络获取数据失败");
    [self.delegate getArrayByCityName:nil];
}

@end
