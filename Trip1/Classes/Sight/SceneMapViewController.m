//
//  SceneMapViewController.m
//  Trip1
//
//  Created by lanou on 15/6/29.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "SceneMapViewController.h"
#import "NSString+URL.h"
#import "SceneModel.h"
#import "MBProgressHUD.h"
#import <CoreLocation/CoreLocation.h>
#define XJHWidth ([[UIScreen mainScreen] bounds].size.width)
#define XJHHeight ([[UIScreen mainScreen] bounds].size.height)
@interface SceneMapViewController ()<UIWebViewDelegate,UIAlertViewDelegate>
{
    UIWebView *_foodWedView;
    CLLocation *location;
}
@property (nonatomic,retain) MBProgressHUD * hud;  //loading
//位置管理者
@property (strong,nonatomic) CLLocationManager *locationManager;

@end

@implementation SceneMapViewController

-(void)dealloc
{
    [_locationManager release];
    [_hud release];
    [_model release];
    [super dealloc];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //小菊花控件
    [self p_setupProgressHud];
    //打开状态栏的小菊花
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    //开启一个 （没开启一个就要在结束的时候相对应的减少一个）
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_foodWedView stopLoading];
    [_foodWedView release];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _foodWedView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, XJHWidth, XJHHeight-64)];
    _foodWedView.delegate = self;
    [self getData];
    
    // Do any additional setup after loading the view.
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    leftBtn.frame = CGRectMake(0, 25, 30, 30);
    [leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:@"back_white_colour@2x.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftBtn] autorelease];
    
    self.navigationItem.title = self.model.name;
    
    
}
-(void)backClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getData
{
    NSDictionary *dic =  self.model.location;
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",@"http://m.amap.com/navi/?dest=",dic[@"lng"],@",",dic[@"lat"],@"&destName=",self.model.name,@"&hideRouteIcon=&key=5eece3e51c7180a1f01705369042c3a4"];
    NSLog(@"%@",url);
    
    NSString *new = [url URLEncodedString];
    NSLog(@"%@",new);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:new]];
    [self.view addSubview:_foodWedView];
    [_foodWedView loadRequest:request];
    
}
#pragma -mark设置loading
-(void)p_setupProgressHud
{
    self.hud = [[[MBProgressHUD alloc] initWithView:self.view] autorelease];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hud];
    [_hud show:YES];
    
}
#pragma -mark UIWebViewDelegate 代理方法
- (void )webViewDidStartLoad:(UIWebView  *)webView
{
}
- (void )webViewDidFinishLoad:(UIWebView  *)webView
{
    //    NSLog(@"1234564654");
    [_hud hide:YES];
    [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
}
//- (void)webView:(UIWebView *)webView  didFailLoadWithError:(NSError *)error
//{
//    [_hud hide:YES];
//    sleep(2);
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误" message:@"请检查网络连接" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alert show];
//    [alert release];
//
//}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//
//    switch (buttonIndex) {
//        case 0:
//            [self.navigationController popViewControllerAnimated:YES];
//            break;
//        case 1:
//            [self getData];
//        default:
//            break;
//    }
//
//}
#pragma -mark开启定位功能
//-(void)getLocation
//{
//    self.locationManager = [[CLLocationManager alloc]init];
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
//        //由于IOS8中定位的授权机制改变，需要进行手动的授权
//        //还需要在info。plist里面添加键值对
//        //一直授权
//        [self.locationManager requestAlwaysAuthorization];
//        //需要的时候授权
//        [self.locationManager requestWhenInUseAuthorization];
//    }
//
//    //定位的一些设置
//    //设置多远更新一下位置，实质就是让代理方法重走一遍
//    self.locationManager.distanceFilter = 10.0f;
//    //设置精确度
//    self.locationManager.desiredAccuracy = 0.50f;
//    //设置代理
//    self.locationManager.delegate = self;
//    //开启更新位置功能
//    [self.locationManager startUpdatingLocation];
//}
#pragma -mark实现定位的方法
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    location = (CLLocation *)[locations lastObject];
//
//    NSDictionary *dic =  self.model.location;
//    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",@"http://m.amap.com/navi/?dest=",dic[@"lng"],@",",dic[@"lat"],@"&destName=",self.model.name,@"&hideRouteIcon=&key=5eece3e51c7180a1f01705369042c3a4"];
//    NSLog(@"%@",url);
//
//    NSString *new = [url URLEncodedString];
//    NSLog(@"%@",new);
//
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:new]];
//     NSLog(@"lan = %f lon =%f ",location.coordinate.latitude,location.coordinate.longitude);
//    [_foodWedView loadRequest:request];
//
//
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"内存警告%s,%d",__FUNCTION__,__LINE__);
    
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
