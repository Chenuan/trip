//
//  PhotosViewController.m
//  Trip1
//
//  Created by lanou on 15/6/24.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "PhotosViewController.h"
#import "SceneModel.h"
#import "PhotosDataByCity.h"
#import "PhotoCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "LGJHeader.h"

#define kCollecionViewImageHeight 280
#import "MJRefresh.h"

#import "PhotosDetailViewController.h"
@interface PhotosViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,photosDataByCityDelegate>
{
    NSString *curentCityName;
}
@property (nonatomic,retain) NSMutableArray *photosArray;
@property (nonatomic,retain) UICollectionView *collectionView;
@property (nonatomic,retain) UIButton *leftButton;
@property (nonatomic,retain) UIAlertView *alertView;
@property (nonatomic,retain) NSTimer *timer;
@property (nonatomic,retain) PhotosDataByCity *photosData;
@end

@implementation PhotosViewController

-(void)dealloc
{

    [[SDImageCache sharedImageCache] clearMemory];

    [self.collectionView.footer endRefreshing];
    _photosData.delegate = nil;
    [_photosData release];
    
    [_timer release];
    [_alertView release];
    _collectionView.delegate = nil;
    [_model release];
    [_photosArray release];
    [_collectionView release];
    [super dealloc];
}
-(PhotosDataByCity *)photosData
{
    if (_photosData == nil) {
        _photosData = [[PhotosDataByCity alloc] init];
        _photosData.delegate = self;
    }
    return [[_photosData retain] autorelease];
}
-(NSMutableArray *)photosArray
{
    if (_photosArray == nil) {
        _photosArray = [[NSMutableArray alloc] init];
//        [self loadPhotosArray];
        [self.collectionView.footer beginRefreshing];

        }
    return [[_photosArray retain] autorelease];
}
//-(void)loadPhotosArray{
//    NSString *cityName = [[NSUserDefaults standardUserDefaults] objectForKey:@"cityName"];
//    curentCityName = cityName;
//    [self addPhotosArrayByCityName:cityName andPage:0 andModelID:self.model.ID];
//}
-(void)addPhotosArrayByCityName:(NSString *)cityName andPage:(int)page andModelID:(NSString *)ID
{
//    __block PhotosViewController *wSelf = self;
    [self.photosData getDataByCityName:cityName andPage:page andModelID:ID];
//    [PhotosDataByCity getDataByCityName:cityName andPage:page andModelID:ID  arrayBlock:^(NSMutableArray *array) {
////        if (wSelf.photosArray == nil) {
////            wSelf.photosArray = [[NSMutableArray alloc] init];
////        }
//        @try {
//            [wSelf.photosArray addObjectsFromArray:array];
//            //        self.leftButton.enabled = YES;
//            //刷新
//            [wSelf.collectionView reloadData];
//            [wSelf.collectionView.footer endRefreshing];
//        }
//        @catch (NSException *exception) {
//            NSLog(@"错误");
//        }
//        @finally {
//            [[SDImageCache sharedImageCache] clearMemory];
//            [[NSURLCache sharedURLCache] removeAllCachedResponses];
//        }
//        
//    }];
}
-(void)getArrayByCityName:(NSMutableArray *)array
{
    if (array == nil) {
        [self.collectionView.footer endRefreshing];
        return;
    }
    
    if (self.photosArray == nil) {
        self.photosArray = [[NSMutableArray alloc] init];
    }
    [self.photosArray addObjectsFromArray:array];
    //刷新
    [self.collectionView reloadData];
    [self.collectionView.footer endRefreshing];
    
    [[SDImageCache sharedImageCache] clearMemory];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}



#pragma -mark 尾部刷新
-(void)footerRefresh
{
    [self addPhotosArrayByCityName:curentCityName andPage:(int)(self.photosArray.count) andModelID:self.model.ID];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    
    leftBtn.frame = CGRectMake(0, 25, 30, 30);
    [leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:@"back_white_colour@2x.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftBtn] autorelease];
    self.leftButton = leftBtn;
    

    self.navigationItem.title = self.model.name;
    [self creatCollectionView];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"网络请求图片错误" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    self.alertView = alert;
    [alert release];
}
-(void)backClick
{
   
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatCollectionView
{

    UICollectionViewFlowLayout *flowout = [[UICollectionViewFlowLayout alloc] init];
    
    flowout.itemSize = CGSizeMake(LGJWaterWidth, LGJWaterWidth);
    flowout.minimumInteritemSpacing = LGJWaterDistance;
    flowout.minimumLineSpacing = LGJWaterDistance;
    flowout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowout.sectionInset = UIEdgeInsetsMake(LGJWaterDistance, LGJWaterDistance, LGJWaterDistance, LGJWaterDistance);
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, LGJWidth, LGJHeight + 49) collectionViewLayout:flowout];
    self.collectionView = collection;
    [self.view addSubview:collection];
    [collection release];
    [flowout release];
    
    collection.delegate = self;
    collection.dataSource = self;
    [collection release];
    collection.backgroundColor = [UIColor whiteColor];
    [collection registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    
    [collection addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    collection.backgroundColor = LGJBackgroundColor;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photosArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    NSString *urlString = [self.photosArray objectAtIndex:indexPath.row];
    cell.model = urlString;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PhotosDetailViewController *photosDetail = [[PhotosDetailViewController alloc] init];
    photosDetail.photosArray = self.photosArray;
    photosDetail.model = self.model;
    photosDetail.contentOffset = CGPointMake((indexPath.row) * LGJPhotoViewCollectionWidth, 0);
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:photosDetail animated:YES];
    [photosDetail release];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [EnabelLeftOrRIght setSideViewEnabelSwip:NO];
    [self.collectionView reloadData];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[SDImageCache sharedImageCache] clearMemory];
    [super viewWillDisappear:animated];
    [EnabelLeftOrRIght setSideViewEnabelSwip:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
