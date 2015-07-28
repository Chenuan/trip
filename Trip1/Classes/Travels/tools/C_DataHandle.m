//
//  C_DataHandle.m
//  Trip1
//
//  Created by ccyy on 15/6/22.
//  Copyright © 2015年 kevin. All rights reserved.
//

#import "C_DataHandle.h"
#import "AFHTTPRequestOperation.h"
#import "TravelList.h"
#import "DetailTravel.h"
#import "SectionHead.h"
#import "MBProgressHUD.h"
@implementation C_DataHandle


+(NSMutableArray *)handleDictionary:(NSDictionary *)dic
{
    NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:10];
    for (NSDictionary *dic1 in dic[@"items"]) {
        
            TravelList *tra = [[[TravelList alloc]init]autorelease];
            [tra setValuesForKeysWithDictionary:dic1];
            [muArray addObject:tra];
        
    }
    return muArray;
}


+(DetailTravel *)dataWithDic:(NSDictionary *)dic
{
    DetailTravel *detailTra = [[[DetailTravel alloc]init]autorelease];
    [detailTra setValuesForKeysWithDictionary:dic];
    NSDictionary *dic1 = dic[@"poi_infos_count"];
    [detailTra setValuesForKeysWithDictionary:dic1];
    NSDictionary *dic2 = dic[@"user"];
    [detailTra setValuesForKeysWithDictionary:dic2];
    return detailTra;
}

//保存区
+(NSMutableArray *)headCellArrayWithDic:(NSDictionary *)dic
{
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
    for (NSDictionary  *dic1 in dic[@"days"]) {
       // NSLog(@"%@",dic1);
       SectionHead *sec  = [[[SectionHead alloc]init]autorelease];
        [sec setValuesForKeysWithDictionary:dic1];
       // NSLog(@"%@,%lu",detailTra.date,detailTra.day);
      //  NSDictionary *dict = dic1[@"waypoints"];
       // [detailTra setValuesForKeysWithDictionary:dict];
      //  NSDictionary *dic2 = dict[@"photo_info"];
        //[detailTra setValue:dic2[@"w"] forKey:@"w"];
        //[detailTra setValue:dic2[@"h"] forKey:@"h"];
      //  NSDictionary *dic3 = dict[@"poi"];
      // [detailTra setValue:dic3[@"name"] forKey:@"name"];
        [mArray addObject:sec];
    }
    return mArray;
}



#pragma -mark 小菊花
+(void)addView:(UIView *)aView HubToView:(UIView *)view
{
    MBProgressHUD *hub = [[[MBProgressHUD alloc]initWithView:aView]autorelease];
    aView.backgroundColor = [UIColor whiteColor];
    hub.center = CGPointMake(aView.frame.size.width/2, aView.frame.size.height/2-80);
    hub.minSize = CGSizeMake(80, 80);
    hub.mode = MBProgressHUDModeIndeterminate;
    hub.animationType = MBProgressHUDAnimationFade;
    hub.opacity = NO;
    hub.dimBackground = NO;
    hub.minShowTime = 2;
   // hub.backgroundColor = [UIColor redColor];
    [aView addSubview:hub];
    [view addSubview:aView];
    [hub show:YES];
}

#pragma -mark设置loading
+(void)addMBprogressHudToView:(UIView *)aView
{
    MBProgressHUD *hud;
    hud = [[[MBProgressHUD alloc] initWithView:aView]autorelease];
    hud.frame = aView.bounds;
    hud.minSize = CGSizeMake(100, 100);
    hud.mode = MBProgressHUDModeCustomView;
    [aView addSubview:hud];
    hud.dimBackground = NO;
    [hud show:YES];
    
    
}
//两页交换动画
+(void)hiddenHubAndView:(UIView *)aView
{
    [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        //动画具体代码
        aView.frame = CGRectMake(160 ,300, 0, 0);
    } completion:^(BOOL finished) {
            [UIView animateWithDuration:0 animations:^{
    
                [aView removeFromSuperview];
             //   NSLog(@"游记－－活动指示器视图已经移除");
                
            }];
    }];
}

//两个view的动画
+(void)changeView:(UIView *)aView andView:(UIView *)bView inSuperView:(UIView *)superView
{
    {

        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.7;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"oglFlip";
        
      static  NSInteger typeID;
        
        switch (typeID) {
            case 0:
                animation.subtype = kCATransitionFromLeft;
                break;
            case 1:
                animation.subtype = kCATransitionFromBottom;
                break;
            case 2:
                animation.subtype = kCATransitionFromRight;
                break;
            case 3:
                animation.subtype = kCATransitionFromTop;
                break;
            default:
                break;
        }
        
        typeID += 1;
        if (typeID > 3) {
            typeID = 0;
        }
    //    NSLog(@" typeId = %ld",typeID);
        
        NSUInteger red = [[superView subviews] indexOfObject:aView];
        NSUInteger white = [[superView subviews] indexOfObject:bView];
        [superView exchangeSubviewAtIndex:red withSubviewAtIndex:white];
        
        [[superView layer] addAnimation:animation forKey:@"animation"];
    }
}

////保存行
//+(NSMutableArray *)cellArrayWithDic:(NSDictionary *)dic
//{
//    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
//    for (NSDictionary  *dic1 in dic[@"days"]) {
//        // NSLog(@"%@",dic1);
//        DetailTravel *detailTra  = [[[DetailTravel alloc]init]autorelease];
//        // NSLog(@"%@,%lu",detailTra.date,detailTra.day);
//        NSArray *array = dic1[@"waypoints"];
//        for (NSDictionary *dict in array) {
//            [detailTra setValuesForKeysWithDictionary:dict];
//            NSDictionary *dic2 = dict[@"photo_info"];
//            [detailTra setValue:dic2[@"w"] forKey:@"w"];
//            [detailTra setValue:dic2[@"h"] forKey:@"h"];
//            NSDictionary *dic3 = dict[@"poi"];
//            [detailTra setValue:dic3[@"name"] forKey:@"name"];
//            [mArray addObject:detailTra];
//        }
//    }
//    return mArray;
//}


@end
