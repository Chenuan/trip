//
//  FoodPicViewController.m
//  Trip1
//
//  Created by lanou on 15/6/25.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "FoodPicViewController.h"
#import "EnabelLeftOrRIght.h"
#import "FoodModel.h"
#import "AsyNetworkTool.h"
#import "FoodPicModel.h"
#import "FoodPicCollectionViewCell.h"
#import "UIImageView+WebCache.h"//SD第三方
#import "MJRefresh.h"
#import "FoodModel.h"
#import "FoodPicListViewController.h"
#import "MBProgressHUD.h"

#define PicUrl @"http://api.breadtrip.com/destination/place/5/"
#define XJHWidth ([[UIScreen mainScreen] bounds].size.width)
#define XJHHeight ([[UIScreen mainScreen] bounds].size.height - 64)
//static int count = 1;
@interface FoodPicViewController ()<UINavigationControllerDelegate,AsyNetworkToolDelegata,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    int lastCount ;
}
@property (nonatomic, retain) NSMutableArray *picArray;
@property (nonatomic, retain) UICollectionView *picCollectionView;
@end

@implementation FoodPicViewController
- (void)dealloc
{

    [_picCollectionView release];
    [_url release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];

    self.picCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, XJHWidth, XJHHeight) collectionViewLayout:[self PicCollectionViewFlowLayout]];
    _picCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_picCollectionView];
    _picCollectionView.delegate = self;
    _picCollectionView.dataSource = self;
    self.picCollectionView.backgroundColor = BackgroundColor;
    
    //添加上拉更新控件
    [self.picCollectionView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];

    [self.picCollectionView.footer beginRefreshing];
    
    //注册
    [_picCollectionView registerClass:[FoodPicCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [_picCollectionView release];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 25, 30, 30);
    [leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:@"back_white_colour@2x.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftBtn] autorelease];
    self.navigationItem.title = self.url.name;
    
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)lodaData:(int)count
{
    NSString *url =[NSString stringWithFormat:@"%@%@/photos/?count=%d",PicUrl,self.url.mID,count];
//    NSLog(@"%@   第%d行",url,__LINE__);
    AsyNetworkTool *asy = [[AsyNetworkTool alloc]initWithUrlString:url];
    asy.delagate = self;
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    //开启一个 （没开启一个就要在结束的时候相对应的减少一个）
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];

    [asy release];
}
-(void)footerRereshing
{
    lastCount = (int)self.picArray.count + 18;
    [self lodaData:lastCount];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.picArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FoodPicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    FoodPicModel *picModel = self.picArray[indexPath.row];
    NSURL *imgelUrl = [NSURL URLWithString:picModel.photo_s];
   
    
    [cell.imageview1 sd_setImageWithURL:imgelUrl placeholderImage:PlaceholderImage];
    return cell;

}
-(UICollectionViewFlowLayout *)PicCollectionViewFlowLayout
{
    UICollectionViewFlowLayout *flowLayout = [[[UICollectionViewFlowLayout alloc]init]autorelease];
    flowLayout.itemSize = CGSizeMake((XJHWidth-8)/3, (XJHWidth-8)/3);
    flowLayout.minimumInteritemSpacing = 3;
    flowLayout.minimumLineSpacing = 3;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(3, 0, 0, 0);
    return flowLayout;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"已选择%ld",(long)indexPath.row);
    FoodPicListViewController *foodPicList = [[FoodPicListViewController alloc]init];
    foodPicList.picListArray = self.picArray;
    foodPicList.PicNumber = indexPath.row;
    foodPicList.mID = self.url.mID;
    
    [foodPicList retureArr:^(NSMutableArray *arr) {
        NSLog(@"%lu",(unsigned long)arr.count);
        
        //这里我用模态 因为模态自带block 所以这里就不用实现这个
        //如果是用pust的就要启动这个
//        self.picArray = arr;
//        lastCount = (int)arr.count;
//        NSLog(@"%d",lastCount);
//        count = 0;
//        [collectionView reloadData];
    }];
    
    [self presentViewController:foodPicList animated:NO completion:^{
        [collectionView reloadData];
    }];    
    [foodPicList release];
}


-(void)asyResult:(id)result
{
    NSDictionary *dic = (NSDictionary *)result;
    [self upDataforModel:dic];
    
}
-(void)upDataforModel:(NSDictionary *)dic
{
    NSArray *arr = dic[@"items"];
    if (arr ==nil) {
        //防止再次有网络的时候会同时加载用户多次拖拽后的数组
        lastCount = (int)self.picArray.count;
        [self.picCollectionView.footer endRefreshing];
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        return;
    }
    [self.picArray removeAllObjects];
    for (NSDictionary *picDic in arr) {
        FoodPicModel * foodPic = [[FoodPicModel alloc]init];
        [foodPic setValuesForKeysWithDictionary:picDic];
        [self.picArray addObject:foodPic];
        [foodPic release];
    }
    
    [self.picCollectionView reloadData];
    [self.picCollectionView.footer endRefreshing];
    
    [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
    sleep(2);
    [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [EnabelLeftOrRIght setSideViewEnabelSwip:NO];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
    [super viewWillDisappear:animated];
    [EnabelLeftOrRIght setSideViewEnabelSwip:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)picArray
{
    if (!_picArray) {
        _picArray = [[NSMutableArray alloc]init];
        
    }
    return [[_picArray retain]autorelease];
    
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
