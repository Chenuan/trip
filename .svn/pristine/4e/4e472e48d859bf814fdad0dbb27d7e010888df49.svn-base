//
//  MapViewController.m
//  Trip1
//
//  Created by ccyy on 15/6/28.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "MapViewController.h"
//#import <MAMapKit/MAMapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "LocationPoint.h"
#import <UIKit/UIKit.h>


@interface MapViewController ()<MKMapViewDelegate>
{
        MKMapView *_mapView;
}

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    // Do any additional setup after loading the view.
    
    [self initMapView];
   // NSLog(@"locationArray = %@",self.locationArray);
     [self addPointLocations];
    
    self.title = @"最近地点";
}
//
-(void)initMapView
{
    
    _mapView = [[[MKMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))]autorelease];;
    //设置地图类型
    _mapView.mapType = MKMapTypeStandard;
    
    //显示用户的位置
 //   _mapView.showsUserLocation = YES;
    
    //设置代理
    _mapView.delegate = self;
    
    [self.view addSubview:_mapView];
    //比例尺
    MKCoordinateSpan span = MKCoordinateSpanMake(0.2, 0.2);
    // 设置地图显示的范围
    LocationPoint *location = [self.locationArray firstObject];
    CLLocationCoordinate2D coordinate =   CLLocationCoordinate2DMake(location.latitude, location.longitude);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [_mapView setRegion:region];
    
     [self addGeodoticPolyLine1];
   // _mapView.showsLabels = YES;
    
}

-(void)addPointLocations
{
    NSInteger a = self.locationArray.count;
    if (self.locationArray.count>50) {
        a = 50;
    }
    for (int i = 0; i < a; i++) {
        LocationPoint *location = self.locationArray[i];
        if (![location.title isEqualToString:@""]) {
            MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
            pointAnnotation.coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude);
            pointAnnotation.title = location.title;
            [_mapView addAnnotation:pointAnnotation];
            [pointAnnotation release];
        }
        
    }
    
}

//实现 <MAMapViewDelegate> 协议中的 mapView:viewForAnnotation:回调函数，设置标注样式。如下所示：

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[ mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier]autorelease];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MKPinAnnotationColorPurple;
        return annotationView ;
    }
    return nil;
}



//继续在ViewController.m文件中，实现<MAMapViewDelegate>协议中的mapView:viewForOverlay:回调函数，设置折线的样式。示例代码如下：

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolylineView *polylineView = [[[MKPolylineView alloc] initWithPolyline:overlay]autorelease];
        
        polylineView.lineWidth = 3.0f;
        polylineView.strokeColor = [UIColor colorWithRed:0.5 green:0.2 blue:0.8 alpha:0.8];
     //  polylineView.lineJoinType = kMALineJoinRound;//连接类型
     //   polylineView.lineCapType = kMALineCapRound;//端点类型
        return polylineView;
    }
    return nil;
}


-(void)addGeodoticPolyLine1{
    NSInteger c = self.locationArray.count;
    if (c > 50) {
        c = 50;
    }
    CLLocationCoordinate2D geodesicCoords[c];
    for (int i = 0; i < c; i++) {
        LocationPoint *location = self.locationArray[i];
        geodesicCoords[i].latitude = location.latitude;
        geodesicCoords[i].longitude = location.longitude;
    }

    //构造大地曲线对象
    MKGeodesicPolyline *geodesicPolyline = [MKGeodesicPolyline polylineWithCoordinates:geodesicCoords count:c];
    [_mapView addOverlay:geodesicPolyline];
}

//-(void)mapView:( MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
//{
//    [_mapView removeFromSuperview];
//    [self.view addSubview:mapView];
//}

-(void)dealloc
{
    NSLog(@"地图dealloc方法执行");
    [_locationArray release];
   // _mapView.showsUserLocation = NO ;
    _mapView.userTrackingMode = MKUserTrackingModeNone;
    [_mapView.layer removeAllAnimations];
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView removeOverlays:_mapView.overlays];
    [_mapView removeFromSuperview];
    _mapView = nil;
    _mapView.delegate =  nil;
     [super dealloc];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
