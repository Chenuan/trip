//
//  AppDelegate.m
//  Trip1
//
//  Created by lanou on 15/6/20.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "RootViewController.h"

#import "TravelViewController.h"

#import "RecommendViewController.h"
#import "YRSideViewController.h"
#import "BaseNavigationViewController.h"
#import "SceneViewController.h"
#import "FoodViewController.h"
#import "FoodListViewController.h"
#import "DomesticCityData.h"
#import "AFHTTPRequestOperation.h"

@interface AppDelegate ()<UINavigationControllerDelegate>
{
    FoodListViewController *fd;
}
@end

@implementation AppDelegate
-(void)dealloc{
//    [_reachability release];
//    [_reachability stopNotifier];
    [_sideViewController release];
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    TravelViewController *travel = [[[TravelViewController alloc] init]autorelease];
    RecommendViewController *recommend = [[[RecommendViewController alloc] init]autorelease];
    
     FoodViewController*food = [[[FoodViewController alloc]init]autorelease];
    
      BaseNavigationViewController *travelNavi = [[[BaseNavigationViewController alloc] initWithRootViewController:travel]autorelease];
    BaseNavigationViewController *recommendNavi = [[[BaseNavigationViewController alloc] initWithRootViewController:recommend]autorelease];;
    
    BaseNavigationViewController *foodNavi = [[[BaseNavigationViewController alloc]initWithRootViewController:food]autorelease];

    

    travelNavi.tabBarItem.title = @"游记";

    recommendNavi.tabBarItem.title = @"推荐";
    
    SceneViewController *scene = [[[SceneViewController alloc] init]autorelease];
    BaseNavigationViewController *sceneNavi = [[[BaseNavigationViewController alloc] initWithRootViewController:scene]autorelease];
    sceneNavi.tabBarItem.title = @"景点";

    foodNavi.tabBarItem.title = @"美食";
    travelNavi.tabBarItem.image = [UIImage imageNamed:@"youji@2x.png"];
    recommendNavi.tabBarItem.image = [UIImage imageNamed:@"tuijian@2x.png"];
    foodNavi.tabBarItem.image = [UIImage imageNamed:@"meishi@2x.png"];
    sceneNavi.tabBarItem.image = [UIImage imageNamed:@"gongjujingdian@2x.png"];

    
    
    
    RootViewController *root = [[[RootViewController alloc] init]autorelease];


    root.viewControllers = @[foodNavi,travelNavi,sceneNavi,recommendNavi];


    
    LeftViewController *left = [[[LeftViewController alloc] init]autorelease];
    RightViewController *right = [[[RightViewController alloc] init]autorelease];
    
    YRSideViewController *sideView = [[[YRSideViewController alloc] initWithNibName:nil bundle:nil]autorelease];
    sideView.leftViewController = left;
    sideView.rightViewController = right;
    sideView.rootViewController = root;

    self.sideViewController = sideView;
    
    self.window.rootViewController = sideView;
    
#pragma mark 获取城市列表和id，并且读入到plist文件列表里面
    NSString *str = @"http://api.breadtrip.com/destination/index_places/8/";
    NSURL *url = [NSURL URLWithString:str];
    AFHTTPRequestOperation *operation = [[[AFHTTPRequestOperation alloc]initWithRequest:[NSURLRequest requestWithURL:url]]autorelease];
    [operation  setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data =   operation.responseData;
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArray = jsonDic[@"data"];
//        NSLog(@"dataArray = %@",dataArray);
        //获取plist文件
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil];
        NSMutableDictionary *plistDic =[ [[NSMutableDictionary alloc]initWithContentsOfFile:filePath]autorelease];
//        NSLog(@"plistDic = %@",plistDic);
        for (NSDictionary *cityDic in dataArray) {
            NSString *name = cityDic[@"name"];
            NSString *cityId   = [NSString stringWithFormat:@"%@/%@",cityDic[@"type"],cityDic[@"id"]];
            NSLog(@"%@,%@",name,cityId);
            [plistDic setObject:cityId forKey:name];
//            NSLog(@"plistDic = %@",plistDic);
        }
        //获取应用程序沙盒的Documents目录
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *plistPath1 = [paths objectAtIndex:0];
        //得到完整的文件名
        NSString *filename=[plistPath1 stringByAppendingPathComponent:@"city.plist"];
        //输入写入
        [plistDic writeToFile:filename atomically:YES];
        //读出来看看
//        NSMutableDictionary *data1 = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
//        NSLog(@"%@", data1);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取城市列表网络加载失败");
    }];
    
    NSOperationQueue *queue = [[[NSOperationQueue alloc]init]autorelease];
    [queue addOperation:operation];
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
