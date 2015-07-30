//
//  SceneDetailViewController.m
//  Trip1
//
//  Created by lanou on 15/6/23.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "SceneDetailViewController.h"
#import "SceneDetailTableViewCell.h"
#import "SceneModel.h"
#import "LGJHeader.h"
#import "SceneDetailHeaderView.h"
#import "EnabelLeftOrRIght.h"
#import "PhotosViewController.h"
#import "SceneMapViewController.h"
#import "SceneMap.h"


#import "FoodMapViewController.h"

@interface SceneDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UIAlertViewDelegate>

@property (nonatomic,retain) UIView *navigationView;
@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,retain) SceneDetailHeaderView *headerView;
@property (nonatomic) BOOL needToPush;
@end

@implementation SceneDetailViewController

-(void)dealloc{
    self.tableView.delegate = nil;
    [_tableView release];
    [_headerView release];
    [_navigationView release];
    [_model release];
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.needToPush = NO;
    self.view.backgroundColor = [UIColor whiteColor];

    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatTableView];
    
#warning 设置navigation隐藏
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    
#warning 从新写自己的navigation
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LGJWidth, 64)];
    navigationView.alpha = 0;
    navigationView.backgroundColor = [UIColor greenColor];
    self.navigationView = navigationView;
    [self.view addSubview:navigationView];
    [navigationView release];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(20, 25, 30, 30);
    [back setImage:[UIImage imageNamed:@"back_white_colour.png"] forState:UIControlStateNormal];
    [self.view addSubview:back];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)back:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    
    //去掉透明颜色
//    CGFloat alphaHeight = ([SceneDetailHeaderView sceneDetailHeaderHeight]) - 64;
//    if (point.y < alphaHeight) {
//        self.navigationView.alpha = point.y / [SceneDetailHeaderView sceneDetailHeaderHeight];
//    }
//    else{
//        self.navigationView.alpha = 1;
//    }
    if (point.y < 0) {
        CGRect frame = CGRectZero;
        CGFloat heightBefore = [SceneDetailHeaderView sceneDetailHeaderHeight];
        CGFloat widthBefore = LGJWidth;
        CGFloat photoHeight = (-1 * (point.y )) + heightBefore ;
    
        CGFloat scale = photoHeight/heightBefore;
        
        frame.size.width = scale * widthBefore;
        frame.size.height = photoHeight;
        frame.origin.y = point.y;
        frame.origin.x = -((frame.size.width - widthBefore) / 2);
        self.headerView.frame = frame;
        
        frame.size.height = photoHeight - 40 ;
        self.headerView.imgView.frame = frame;
    }
    if (point.y > -10 && self.needToPush) {
        
        [self pushToPhotos];
        self.needToPush = NO;
    }
    if (point.y < - 120) {
        self.needToPush = YES;
        
    }
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //headerView复原
    self.headerView.imgView.frame = CGRectMake(0, 0, LGJWidth, [SceneDetailHeaderView sceneDetailHeaderImageViewHeight]);
    
    [EnabelLeftOrRIght setSideViewEnabelSwip:YES];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [EnabelLeftOrRIght setSideViewEnabelSwip:NO];
}
#pragma -mark creattabelView
-(void)creatTableView{
    
    UITableView *tabel = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LGJWidth,LGJHeight + 49 + 64 ) style:UITableViewStyleGrouped];

    [self.view addSubview:tabel];
    self.tableView = tabel;
    
    tabel.showsVerticalScrollIndicator = YES;
    tabel.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tabel.delegate = self;
    tabel.dataSource = self;

    tabel.backgroundColor = [UIColor whiteColor];
    [tabel release];
    
}
#pragma -mark 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"SceneDetailCell";
    
    NSInteger row = indexPath.row;
    
    SceneDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[SceneDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId] autorelease];
    }
    
    cell.model = [self getThecontentByIndexPath:indexPath];
    
    if (cell.model.length == 0) {
        return cell;
    }
    
    switch (row) {
        case 0:
        {
            cell.titleLabel.text = @"概况";
            break;
        }
        case 1:
        {
            cell.titleLabel.text = @"地址";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case 2:
        {
            cell.titleLabel.text = @"到达方式";
            break;
        }
        case 3:
        {
            cell.titleLabel.text = @"开放时间";
            break;
        }
        case 4:
        {
            cell.titleLabel.text = @"联系方式";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        default:
            
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 1) {
        SceneMapViewController *map = [[SceneMapViewController alloc] init];
        map.model = self.model;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:map animated:YES];
        [map release];
        
        
//        SceneMap *map = [[SceneMap alloc] init];
//        map.model = self.model;
//        self.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:map animated:YES];
//        [map release];
    
    }
    else if(row == 4)
    {
        UIAlertView *callView = [[UIAlertView alloc]initWithTitle:nil message:self.model.tel delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
        [callView show];
        NSLog(@"电话功能被激活");
    }
}

#pragma -mark激活电话功能
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //激活电话功能
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.model.tel]]];
    }
}

-(NSString *)getThecontentByIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
            return self.model.baseDescription;
            break;
        case 1:
            return self.model.address;
            break;
        case 2:
            return self.model.arrival_type;
            break;
        case 3:
            return self.model.opening_time;
            break;
        case 4:
            return self.model.tel;
            break;
        default:
            break;
    }
    return nil;
}


#pragma -mark 代理方法

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [SceneDetailHeaderView sceneDetailHeaderHeight];
    }
    else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *content = [self getThecontentByIndexPath:indexPath];
    return [SceneDetailTableViewCell rowHeightBycontent:content];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        SceneDetailHeaderView *view = [[SceneDetailHeaderView alloc] init];
        view.imageUrlString = self.model.cover_route_map_cover;
        self.headerView = view;
        [view.photosButton addTarget:self action:@selector(photosButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photos:)];
        [view.imgView addGestureRecognizer:tap];
        
        [view release];
        return view;
    }
    else{
        return nil;
    }
}
-(void)photosButtonClick:(UIButton *)btn
{
    [self pushToPhotos];
}
-(void)photos:(UITapGestureRecognizer *)tap{
    [self pushToPhotos];
}

-(void)pushToPhotos{
    PhotosViewController *photos = [[[PhotosViewController alloc] init]autorelease];
    photos.model = self.model;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:photos animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
