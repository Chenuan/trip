

#import "TravelViewController.h"
#import "TravelListCell.h"
#import "TravelList.h"
#import "C_DataHandle.h"
#import "AFHTTPRequestOperation.h"
#import "DetailTravelController.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "TraCollectionViewCell.h"
#import "MJRefresh.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "YRSideViewController.h"
#import "AppDelegate.h"

#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationDrop.h"
#import "PopupView.h"

#define XJHWidth ([[UIScreen mainScreen] bounds].size.width)
#define XJHHeight ([[UIScreen mainScreen] bounds].size.height)

@interface TravelViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UIView *_hubView;
    UICollectionView *_collectionView;
}

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain,nonatomic) NSMutableArray *travelListArray;
@property (nonatomic,retain) NSString *cityName;

@end

@implementation TravelViewController

//************************************  collectionView  *****************************
-(void)initCollectionView
{
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, XJHWidth, XJHHeight-49) collectionViewLayout:[self PicListCollectionViewFlowLayout]];
    [self.view addSubview:_collectionView];
    _collectionView.delegate = self;
    _collectionView.dataSource =self;
   // _collectionView.pagingEnabled =YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
   // NSLog(@"------------");
   // _collectionView.contentOffset = CGPointMake(XJHWidth*self.PicNumber+(self.PicNumber*20), XJHHeight);
    
    
    //注册
   [_collectionView registerClass:[TraCollectionViewCell class] forCellWithReuseIdentifier:@"cCell"];
    [_collectionView release];

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sectio
{
// NSLog(@"%ld",self.travelListArray.count);
    return self.travelListArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    TraCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cCell" forIndexPath:indexPath];
    
    TravelList *tra = self.travelListArray[indexPath.row];
   //  NSLog(@"%@",tra.cover_image);
    NSURL *imageUrl = [NSURL URLWithString:tra.cover_image];
    [cell.image_view sd_setImageWithURL:imageUrl];
    cell.cTitleLabel.text = tra.name;
    
  
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"已选择%ld",(long)indexPath.row);
    DetailTravelController *dvc = [[[DetailTravelController alloc]init]autorelease];
    dvc.tra = self.travelListArray[indexPath.row];
    [dvc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:dvc animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    
}

-(UICollectionViewFlowLayout *)PicListCollectionViewFlowLayout
{
    UICollectionViewFlowLayout *flowLayout = [[[UICollectionViewFlowLayout alloc]init]autorelease];
    flowLayout.itemSize = CGSizeMake((XJHWidth-9)/3, (XJHWidth-5)/3);
    flowLayout.minimumInteritemSpacing = 3;
    flowLayout.minimumLineSpacing = 3;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(1, 0, 0, 0);
    
    return flowLayout;

}


-(void)changeView
{
   
    [C_DataHandle changeView:self.tableView andView:_collectionView inSuperView:self.view];

}

//**********************************  tableView  ********************************


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
 
    //添加collectionView
    [self initCollectionView];
//    [self.view bringSubviewToFront:self.tableView];
    //添加活动指示器
    _hubView = [[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds]autorelease];
    _hubView.backgroundColor = [UIColor grayColor];
    [C_DataHandle addView:_hubView HubToView:self.view];
    
    self.cityName = [[NSUserDefaults standardUserDefaults] objectForKey:@"cityName"];
    if (self.cityName == nil) {
        self.cityName = @"上海";
    }
    self.navigationItem.title = self.cityName;
    
    //获得URL
    [self refreshBaseID];
    
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doNotification:) name:@"notificationCityName" object:nil];
    
    //添加多个左右按钮
    [self addButtons];
    
    //第一次请求数据
    [self getDataByUrlString:self.BaseID];

    //xib TableView注册
    [self.tableView registerNib:[UINib nibWithNibName:@"TravelListCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    //添加上拉更新控件
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing:)];
    [_collectionView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing:)];
    
}

-(void)addButtons
{
 
    UIButton *rightButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton2.frame = CGRectMake(0, 0, 20, 20);
    [rightButton2 setImage:[UIImage imageNamed:@"iconfont-jiugongge (2).png"]  forState:UIControlStateNormal];
    [rightButton2 addTarget:self action:@selector(changeView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton2 = [[UIBarButtonItem alloc]initWithCustomView:rightButton2];

    self.navigationItem.rightBarButtonItem = barButton2;
    
    UIButton *Button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    Button3.frame = CGRectMake(0, 0, 30, 30);
    [Button3 setImage:[UIImage imageNamed:@"showLeft.png"]  forState:UIControlStateNormal];
    [Button3 addTarget:self action:@selector(cityChoose) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:Button3]autorelease];
    
    [barButton2 release];

}
    


-(void)refreshBaseID
{
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"city.plist"];
    
    //读出来看看
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    NSLog(@"datadic  = %ld", dataDic.count);
    NSString *string  = [dataDic objectForKey: self.cityName];
    self.BaseID = [NSString stringWithFormat:@"http://api.breadtrip.com/destination/place/%@/trips/",string];
    NSLog(@"self.baseid = %@",self.BaseID);
    
}

#pragma -mark 通知执行的方法
-(void)doNotification:(NSNotification *)notification
{
    NSDictionary *dic = notification.userInfo;
    NSString *cityname = dic[@"city"];
   // NSLog(@"cityname = %@",cityname);
  //  NSLog(@"self.cityName = %@ ",self.cityName);
    if (![self.cityName isEqualToString:cityname]) {
        self.cityName = cityname;
        [[NSUserDefaults standardUserDefaults]setObject:cityname forKey:@"cityName"];
         self.navigationItem.title = cityname;
        [self.travelListArray removeAllObjects];
        [self refreshBaseID];
        [self getDataByUrlString:self.BaseID];
       
    }
    
}

#pragma -mark 懒加载
-(NSMutableArray *)travelListArray
{
    if (_travelListArray == nil) {
        _travelListArray = [[NSMutableArray alloc]init];
    }
    return [_travelListArray retain];
}

#pragma -mark 数据
-(void)getDataByUrlString:(NSString *)urlString
{
    static int c = 0;

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic=[NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"获取到的数据为：%@",dic);
        NSArray *array = [C_DataHandle handleDictionary:dic];
        for (TravelList *tra in array) {
            [_travelListArray addObject:tra];
        }
       // NSLog(@"%lu",_travelListArray.count);
        if (c == 0) {
            [C_DataHandle  hiddenHubAndView:_hubView];
            c++;
        }
         [self.tableView reloadData];
        [_collectionView reloadData];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求数据发生错误！%@",error);
    }];
   
    NSOperationQueue *queue = [[[NSOperationQueue alloc] init]autorelease];
    [queue addOperation:operation1];
}


#pragma -mark tableView的代理方法
//行数
-(NSInteger)tableView:( UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  //  NSLog(@"游记列表的行数是 %lu",self.travelListArray.count);
    if (self.travelListArray.count==0) {
        return 1;
    }else{
    return self.travelListArray.count;
    }
}

//cell
-( UITableViewCell *)tableView:( UITableView *)tableView cellForRowAtIndexPath:( NSIndexPath *)indexPath
{
    if (self.travelListArray.count==0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"acell"];
        cell.textLabel.text = @"该城市暂无精选游记，等待优质游记中";
        return cell;
    }else{
    TravelListCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    TravelList *tra = self.travelListArray[indexPath.row];
    cell.tralist = tra ;
    return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 114;
}

//选中cell之后
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.travelListArray.count != 0) {
        DetailTravelController *dvc = [[[DetailTravelController alloc]init]autorelease];
        dvc.tra = self.travelListArray[indexPath.row];
        [dvc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:dvc animated:YES];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}


//-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:( NSIndexPath *)indexPath
//{
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

//*********************** 下拉刷新 *******************
//    http://api.breadtrip.com/destination/place/3/12/trips/?start=20&sign=6b62f9be134770becb64064b5d3af37c

- (void)footerRereshing:(UIScrollView *)view
{
    NSInteger a = self.travelListArray.count;
    sleep(1);
   static int lastCount= 20;
   static int i = 1 ;
    NSString *urlStr = [NSString stringWithFormat:@"%@?start=%d",self.BaseID,lastCount];
//    NSLog(@"urlStr = %@",urlStr);
    [self getDataByUrlString:urlStr];
    i++;
    lastCount= 20*i;
    if ([self.tableView.footer isRefreshing]) {
        [self.tableView.footer endRefreshing];
    }
    if ([_collectionView.footer isRefreshing]) {
        [_collectionView .footer endRefreshing];
    }
    NSInteger b = self.travelListArray.count;
    if (a==b) {
        [self.tableView.footer noticeNoMoreData];
        [_collectionView.footer noticeNoMoreData];
}
}

//- (void)footerRereshing2
//{
//    sleep(1);
//    static int lastCount= 20;
//    static int i = 1 ;
//    NSString *urlStr = [NSString stringWithFormat:@"%@?start=%d",self.BaseID,lastCount];
//    [self getDataByUrlString:urlStr];
//    i++;
//    lastCount= 20*i;
//    [_collectionView.footer endRefreshing];
//}

#pragma -mark 左右侧滑动作按键
-(void)cityChoose
{
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    YRSideViewController *sideViewController=[delegate sideViewController];
    [sideViewController showLeftViewController:YES];
    
}

-(void)settings
{
    AppDelegate *delegate = [[UIApplication sharedApplication]delegate];
    YRSideViewController *sideViewController = delegate.sideViewController;
    [sideViewController showRightViewController:YES];
    
//    PopupView *view = [PopupView defaultPopuView];
//    view.parentVC = self;
//    [self lew_presentPopupView:view animation:[LewPopupViewAnimationDrop new] dismissed:^{
//        
//    }];
}




- (void)dealloc {
    [_BaseID release];
    [_tableView release];
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
    [_travelListArray release];
    [_cityName release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
