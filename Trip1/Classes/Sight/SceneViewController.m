//
//  SceneViewController.m
//  Trip1
//
//  Created by lanou on 15/6/22.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "SceneViewController.h"
#import "DomesticCityData.h"
#import "DomesticCity.h"
#import "SceneModel.h"
#import "LGJHeader.h"
#import "SceneTableViewCell.h"
#import "SceneDetailViewController.h"
#import "SceneDataByCity.h"
#import "LGJTools.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "YRSideViewController.h"
#import "PhotosDetailViewController.h"
#import "SDImageCache.h"

@interface SceneViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
{
    NSString *currentCityName;
}
@property (nonatomic,retain) DomesticCity *model;
@property (nonatomic,retain) NSMutableArray *sightsArray;
@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,retain) MBProgressHUD *hud;  //loading
@end

@implementation SceneViewController
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"notificationCityName" object:nil];
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    [_hud release];
    [_sightsArray release];
    [_tableView release];
    [_model release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
#warning 设置代理
    self.navigationController.delegate = self;
    
    currentCityName = [[NSUserDefaults standardUserDefaults] objectForKey:@"cityName"];
    
    
    if (currentCityName == nil) {
        currentCityName = @"上海";
    }
    self.navigationItem.title = currentCityName;
    [self creatTableView];
    //小菊花控件
    [self p_setupProgressHud];
    //通知第一步
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationReceive:) name:@"notificationCityName" object:nil];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"showLeft@2x"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftBtn] autorelease];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0,5, 25, 25);
    [rightBtn addTarget:self action:@selector(showRight) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"showRight@2x"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:rightBtn] autorelease];
    self.tableView.backgroundColor = BackgroundColor;
}
-(void)showLeft
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    YRSideViewController *sideView = app.sideViewController;
    [sideView showLeftViewController:YES];
}
-(void)showRight
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    YRSideViewController *sideView = app.sideViewController;
    [sideView showRightViewController:YES];
}

-(void)notificationReceive:(NSNotification *)notification
{
    NSString *cityName = [notification.userInfo objectForKey:@"city"];
    if (cityName == currentCityName) {
        //如果名字相同，不需要刷新
        return;
    }
    currentCityName = cityName;
    [self.sightsArray removeAllObjects];
    [self.tableView reloadData];
    //小菊花控件
    [self p_setupProgressHud];
    self.navigationItem.title = cityName;
    [self addSightsArrayByCityName:cityName Page:0];
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
#pragma -mark creattabelView
-(void)creatTableView{
    
    UITableView *tabel = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LGJWidth, LGJHeight) style:UITableViewStylePlain];
    [self.view addSubview:tabel];
    [tabel release];
    tabel.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabel.delegate = self;
    tabel.dataSource = self;
    tabel.rowHeight = LGJSceneRowHeight;
    self.tableView = tabel;
    
    //添加上拉更新控件
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
}
#pragma -mark下拉刷新数据
- (void)footerRereshing
{
    
    [self addSightsArrayByCityName:currentCityName Page:(int)self.sightsArray.count];
}
#warning 设置代理方法
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[SceneDetailViewController class]] || [viewController isKindOfClass:[PhotosDetailViewController class]]) {
        [navigationController setNavigationBarHidden:YES animated:animated];
        [self.navigationController.view bringSubviewToFront:self.navigationController.navigationBar];
    }
    else if([navigationController isNavigationBarHidden] ){
        [navigationController setNavigationBarHidden:NO animated:animated];
    }
}

-(NSMutableArray *)sightsArray
{
    if (_sightsArray == nil) {
        _sightsArray = [[NSMutableArray alloc] init];
        [self loadSightsArray];
    }
    return [[_sightsArray retain] autorelease];
}
//第一次导入数据
-(void)loadSightsArray{
    [self addSightsArrayByCityName:currentCityName Page:0];
}
//刷新后得数据
-(void)addSightsArrayByCityName:(NSString *)cityName Page:(int)page
{
    __block NSMutableArray *wSightsArray = _sightsArray;
    __block UITableView *wTabelView = _tableView;
    __block MBProgressHUD *wHub = _hud;
    [SceneDataByCity getDataByCityName:cityName andPage:page arrayBlock:^(NSMutableArray *array) {
        if (wSightsArray == nil) {
            wSightsArray = [[NSMutableArray alloc] init];
        }
        [wSightsArray addObjectsFromArray:array];
        [wTabelView reloadData];
        [wTabelView.footer endRefreshing];
        [wHub hide:YES];
        
        [[SDImageCache sharedImageCache] clearMemory];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
    }];
}

#pragma -mark 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sightsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"SceneCell";
    SceneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[SceneTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId] autorelease];
    }
    SceneModel *model = self.sightsArray[indexPath.row];
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SceneDetailViewController *detailScene = [[SceneDetailViewController alloc] init];
    detailScene.model = self.sightsArray[indexPath.row];
    
    //隐藏tabBar
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailScene animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
    [detailScene release];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
