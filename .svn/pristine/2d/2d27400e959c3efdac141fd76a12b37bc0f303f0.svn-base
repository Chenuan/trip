//
//  SceneMap.m
//  Trip1
//
//  Created by lanou on 15/7/1.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "SceneMap.h"
#import "LGJHeader.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h> 

#import "SceneModel.h"
#import "LGJAnnotation.h"
@interface SceneMap ()<MKMapViewDelegate>
@property (nonatomic,retain)CLLocationManager *locationManager;
@property (nonatomic,retain)MKMapView *mapView;
@property (nonatomic) CLLocationCoordinate2D myLocation2D;//显示我的位置的2D
@property (nonatomic) CLLocationCoordinate2D destination2D;//显示我的位置的2D
@end

@implementation SceneMap
-(void)dealloc
{

    self.mapView.showsUserLocation = NO;
    self.mapView.userTrackingMode  = MKUserTrackingModeNone;
    [self.mapView.layer removeAllAnimations];
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView removeFromSuperview];
  
    self.mapView.delegate = nil;
    self.mapView = nil;
    self.locationManager = nil;
    [_model release];
    [super dealloc];
}
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self.mapView removeFromSuperview];
    [self.view insertSubview:self.mapView atIndex:0];
//    [self.view addSubview:self.mapView];
}

-(CLLocationManager *)locationManager
{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return [[_locationManager retain] autorelease];
}                                                                                                                                                                                                                                                                          

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager requestWhenInUseAuthorization];
    }
    self.mapView = [[[MKMapView alloc] initWithFrame:CGRectMake(0, 0, LGJWidth, LGJHeight + 49)] autorelease];
    [self.view addSubview:self.mapView];
    
    
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate =self;
    [self loadDestination];
   
    //地图类型切换
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, LGJHeight + 49 - 60, 35, 35)];
    [self.view addSubview:btn];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = btn.frame.size.width / 2;
    [btn setTitle:@"卫星" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.backgroundColor = [UIColor colorWithRed:0.2 green:0.5 blue:0.3 alpha:0.5];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn release];
    
    //我的位置
    UIButton *myLocationBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, LGJHeight + 49 - 60 - 45, 35, 35)];
    [self.view addSubview:myLocationBtn];
    myLocationBtn.layer.masksToBounds = YES;
    myLocationBtn.layer.cornerRadius = myLocationBtn.frame.size.width / 2;
    [myLocationBtn setTitle:@"位置" forState:UIControlStateNormal];
    [myLocationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    myLocationBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    myLocationBtn.backgroundColor = [UIColor colorWithRed:0.2 green:0.5 blue:0.3 alpha:0.5];
    [myLocationBtn addTarget:self action:@selector(myLocation:) forControlEvents:UIControlEventTouchUpInside];
    [myLocationBtn release];
}






-(void)myLocation:(UIButton *)btn
{
    self.mapView.showsUserLocation = YES;
//    设置地图的精确度以及显示用户位置的信息
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);//比例尺
    MKCoordinateRegion region = MKCoordinateRegionMake(self.myLocation2D, span);
    [self.mapView setRegion:region];
    [self drawLine];
}
-(void)btnClick:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"卫星"]) {
        [btn setTitle:@"地图" forState:UIControlStateNormal];
        self.mapView.mapType = MKMapTypeHybrid;
    }
    else if ([btn.titleLabel.text isEqualToString:@"地图"]) {
        [btn setTitle:@"卫星" forState:UIControlStateNormal];
        self.mapView.mapType = MKMapTypeStandard;
    }
    
}

-(void)drawLine{
    //画线
    
    CLLocationCoordinate2D from = self.myLocation2D;
    CLLocationCoordinate2D to = self.destination2D;
    //将2D类型转化为PlaceMark
    MKPlacemark *fromMark = [[MKPlacemark alloc] initWithCoordinate:from addressDictionary:nil];
    MKPlacemark *toMark = [[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil];
    //创建item
    MKMapItem *fromItem = [[MKMapItem alloc] initWithPlacemark:fromMark];
    MKMapItem *toItem = [[MKMapItem alloc] initWithPlacemark:toMark];
    [fromMark release];
    [toMark release];
    //设置请求
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = fromItem;
    request.destination = toItem;
    //如果两点之间有多条线路会返回多条，默认是NO；
//    request.requestsAlternateRoutes = YES;//设置多条路线；
    
    //创建路线信息
    MKDirections *direction = [[MKDirections alloc] initWithRequest:request];
    //画线
    [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
            NSLog(@"error");
        }
        else
        {
            for (MKRoute *route in response.routes) {
                //                MKRoute *route = response.routes[0];
                //将线路添加到地图上
                [self.mapView addOverlay:route.polyline];
            }
            
            
        }
    }];
    [fromItem release];
    [toItem release];
    [request release];
    [direction release];
}
//实现在地图上画线的代理方法
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    
    MKPolylineRenderer *renderer = [[[MKPolylineRenderer alloc] initWithOverlay:overlay] autorelease];
    //设置线路的宽度
    renderer.lineWidth = 2.0f;
    //设置线路的颜色
    renderer.strokeColor = [UIColor purpleColor];
    return renderer;
}


-(void)loadDestination
{
    double lat = [[self.model.location objectForKey:@"lat"] doubleValue];
    double lng = [[self.model.location objectForKey:@"lng"] doubleValue];
    //获取点击的点
//    CGPoint point = CGPointMake(self.model.location,  );
    //转化为地图的2D坐标
    CLLocationCoordinate2D coordinate = {lat,lng};
    self.destination2D = coordinate;
    //创建标注视图
    LGJAnnotation *annotation = [[LGJAnnotation alloc] init];
    
    annotation.coordinate = coordinate;
    annotation.title = self.model.name;
    annotation.subtitle = self.model.address;
    
    [self.mapView addAnnotation:annotation];
    [annotation release];
    
    
    //设置地图的精确度以及显示用户位置的信息
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);//比例尺
    MKCoordinateRegion region = MKCoordinateRegionMake(self.destination2D, span);
    [self.mapView setRegion:region];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
   
    CLLocationCoordinate2D point = userLocation.location.coordinate;
    CLLocation *location = [[CLLocation alloc] initWithLatitude:point.latitude longitude:point.longitude];
    //位置反编码
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //使用位置反编码对象获取位置信息
    
    __block MKUserLocation *wUserLocation = userLocation;
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark *pl in placemarks) {
            
            wUserLocation.title = pl.name;
            wUserLocation.subtitle = [pl.thoroughfare stringByAppendingString:pl.subThoroughfare];
            NSString *sub = wUserLocation.subtitle;
            NSString *name = pl.name;
            if (sub != nil) {
                wUserLocation.title = [name stringByReplacingOccurrencesOfString:sub withString:@""];
            }
        }
    }];
    [location release];
    [geocoder release];
    
     self.myLocation2D = userLocation.location.coordinate;
//    //设置地图的精确度以及显示用户位置的信息
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);//比例尺
//    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.location.coordinate, span);
//    [self.mapView setRegion:region];
//    self.mapView.region.center = userLocation.location.coordinate;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [EnabelLeftOrRIght setSideViewEnabelSwip:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [EnabelLeftOrRIght setSideViewEnabelSwip:NO];
}

@end
