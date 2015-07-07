//
//  SceneDataByCity.m
//  Trip1
//
//  Created by lanou on 15/6/23.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "SceneDataByCity.h"
#import "DomesticCity.h"
#import "DomesticCityData.h"
#import "LGJHeader.h"
#import "SceneModel.h"

@implementation SceneDataByCity
+(void)getDataByCityName:(NSString *)cityName andPage:(int)page arrayBlock:(void(^)(NSMutableArray *array))block
{
    DomesticCityData *shanghai = [DomesticCityData shareInstance];
    DomesticCity *model = [shanghai.domesticCityDic objectForKey:cityName];
    
    NSString *scenePath = [NSString stringWithFormat:@"%@pois/sights/?sort=default&start=%d",model.fullPath,page];
    [NSString sendAsynRequestGetDataByUrlString:scenePath data:^(NSData *data) {
        NSMutableArray *sightsArray = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
        if (data != nil) {
            NSError *error = nil;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error == nil) {
                NSArray *arr = [dic objectForKey:@"items"];
                for (NSDictionary *tempDic in arr) {
                    SceneModel *modelSc = [[SceneModel alloc] init];
                    [modelSc setValuesForKeysWithDictionary:tempDic];
                    [sightsArray addObject:modelSc];
                    
                    [modelSc release];
                }
            }
        }
        block(sightsArray);
        
    }];
}
@end
