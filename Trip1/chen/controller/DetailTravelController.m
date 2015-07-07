#import "DetailTravelController.h"
#import "AFJSONRequestOperation.h"
#import "C_DataHandle.h"
#import "DetailTravel.h"
#import "UIImageView+AFNetworking.h"
#import "DetailTableCell.h"
#import "SectionHead.h"
#import "MBProgressHUD.h"
#import "MapViewController.h"
#import "LocationPoint.h"
#import "NSString+URL.h"
#import "UMSocial.h"
#import "PicTravelViewController.h"
#import "LineViewController.h"
#import "SelfViewController.h"
#import "UIImageView+WebCache.h"
#import "EnabelLeftOrRIght.h"
#import "RecommendViewController.h"

#define ShareKey @"5590ae1b67e58ecca200062b"


@interface DetailTravelController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIWebViewDelegate,UIAlertViewDelegate>
{
    UIImageView *_hubView;
    UIImageView *_hubView2;
}
@property (retain, nonatomic) IBOutlet UIImageView *smallHeadPhotoImageView;
@property (retain, nonatomic) IBOutlet UILabel *cityLabel;
@property (retain, nonatomic) IBOutlet UILabel *milesLabel;
@property (retain, nonatomic) IBOutlet UILabel *sightLabel;
@property (retain, nonatomic) IBOutlet UILabel *fightLabel;
@property (retain, nonatomic) IBOutlet UILabel *mallLabel;
@property (retain, nonatomic) IBOutlet UILabel *hotelLabel;


@property (retain, nonatomic) IBOutlet UILabel *likeLabel;
@property (retain, nonatomic) IBOutlet UILabel *daysLabel;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UIImageView *mapImageView;

@property ( nonatomic,retain) MBProgressHUD *hud;



//@property (nonatomic,retain) NSArray *detailTravelArray;
@property (nonatomic,retain) NSMutableArray *sectionArray;
@property (nonatomic,retain) NSMutableArray *modelArray;

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *DetailHeadView;
@property (retain, nonatomic) IBOutlet UIView *DetailView2;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (retain, nonatomic) IBOutlet UIWebView *webView;

@property (retain, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *secondViewLeading;


@property (nonatomic, assign) BOOL first;
@property (nonatomic, assign) BOOL first1;
@property (nonatomic,assign) CGFloat h1;
@property (nonatomic,assign) CGFloat h2;

@property  (nonatomic,retain) NSMutableArray *locationArray;
@property  (nonatomic,retain) LocationPoint *location;
@property  (nonatomic,assign) NSInteger id2;



@end

@implementation DetailTravelController

-(void)updateViewConstraints
{
    [super updateViewConstraints];
    self.viewWidth.constant = (CGRectGetHeight([UIScreen mainScreen].bounds) *2-64);
    self.secondViewLeading.constant = (CGRectGetHeight([UIScreen mainScreen].bounds)-64);

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //禁止滑动进入左右页面
    [EnabelLeftOrRIght setSideViewEnabelSwip:NO];
    [self.navigationController setNavigationBarHidden:NO];

}

-(void)doNotification:(NSNotification *)notification
{
    NSDictionary *dic = notification.userInfo;
    NSString *travelIDString = dic[@"travelID"];
    NSLog(@"travelIDString = %@",dic[@"travelID"]);
    self.travelID = travelIDString;
    [_sectionArray removeAllObjects];
    [_modelArray removeAllObjects];
    [self getSectionArrayByUrlString:self.travelID];
    [self getModelArrayAndDataByUrlString:self.travelID];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    


    //导航栏按钮
    [self addNavBarItems];
    //左滑返回功能开启
     self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    

    //添加活动指示器
    _hubView = [[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds]autorelease];
    _hubView.image = [UIImage imageNamed:@"huodongzhishiqi2.png"];
    [C_DataHandle addView:_hubView HubToView:self.view];

    //推荐页面传过来的，进行判断
    NSArray *viewControlerArray = self.navigationController.viewControllers;
  //  NSLog(@"------------------- = %@",viewControlerArray);
    if (![[viewControlerArray firstObject] isKindOfClass:[RecommendViewController class]]) {
         self.travelID = [NSString stringWithFormat:@"%ld",self.tra.id1];
    }
   
 
//    //获取标题栏数据
//    [self getSectionArrayByUrlString:self.travelID];
    
    [self.navigationController setNavigationBarHidden:NO];
    // self.navigationController.hidesBarsOnSwipe = YES;
    //获取页面1的数据
    [self getData1WithString:self.travelID];
    
    //获取页面2的数据
    [self getModelArrayAndDataByUrlString:self.travelID];

    
    self.locationArray = [NSMutableArray arrayWithCapacity:10];
    
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailTableCell" bundle:nil] forCellReuseIdentifier:@"dCell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 150;
    
    self.tableView.tableHeaderView.tintColor = [UIColor orangeColor];
    
}
-(void)addNavBarItems
{
    //添加多个右按钮
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"iconfont-fenxiang"  ofType:@"png"];
    UIImage *imageRight1 = [[UIImage alloc] initWithContentsOfFile:imagePath];
    UIButton *right1 = [UIButton buttonWithType:UIButtonTypeCustom];
    right1.frame = CGRectMake(0, 0, 20, 20);
    [right1 setImage:imageRight1 forState:UIControlStateNormal];
    [right1 addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton1 = [[UIBarButtonItem alloc]initWithCustomView:right1];
    
    NSString *imagePath2 = [[NSBundle mainBundle] pathForResource:@"iconfont-18"  ofType:@"png"];
    UIImage *imageRight2 = [[UIImage alloc] initWithContentsOfFile:imagePath2];
    UIButton *right2 = [UIButton buttonWithType:UIButtonTypeCustom];
    right2.frame = CGRectMake(15, 0, 20, 20);
    [right2 setImage:imageRight2 forState:UIControlStateNormal];
  [ right2 addTarget:self action:@selector(leftRightChange) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton2 = [[UIBarButtonItem alloc]initWithCustomView:right2];
   
    
     NSArray *buttonArray = [[NSArray alloc] initWithObjects:rightButton1,rightButton2 ,nil];
    self.navigationItem.rightBarButtonItems = buttonArray;

    UIButton *leftButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)]autorelease];
    
    [leftButton addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *homeItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [leftButton setBackgroundImage:[[UIImage imageNamed:@"iconfont-fanhui (2).png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0]forState:UIControlStateNormal];//拉伸背景图片以适应button
     self.navigationItem.leftBarButtonItem = homeItem;
  
    
    [rightButton1 release];
    [rightButton2 release];
    [homeItem release];
    [buttonArray release];

}


#pragma -mark 懒加载，同时得到保存对象的数组
-(NSMutableArray *)modelArray
{
    if (_modelArray == nil) {
        _modelArray = [[NSMutableArray alloc]init];
       
    }
    return [_modelArray retain];
    
}
-(void)getModelArrayAndDataByUrlString:(NSString *)string
{
    NSString *str=[NSString stringWithFormat:@"http://api.breadtrip.com/trips/%@/waypoints/?target_type=3&target_id=12&sign=571fb52843d48c8d39cce1c592b26d05",string];
    NSLog(@"url = %@",str);
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    从URL获取json数据
    AFJSONRequestOperation *operation2 = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary* JSON) {
          //NSLog(@"获取到的数据为：%@",JSON);
        [self modelArrayWithDic:JSON];
        [self.tableView reloadData];
        
      } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id data) {
        NSLog(@"发生错误！%@",error);
    }];
    [operation2 start];
}

//解析数据，得到model对象的数组
-(void)modelArrayWithDic:(NSDictionary *)dic
{

//    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
    for (NSDictionary  *dic1 in dic[@"days"]) {
        // NSLog(@"%@",dic1);
//-----------------------------
        SectionHead *sec  = [[[SectionHead alloc]init]autorelease];
        [sec setValuesForKeysWithDictionary:dic1];
        [self.sectionArray addObject:sec];
    
        //开始就跳到第二个页面
        self.scrollView.contentOffset = CGPointMake( 0,self.view.frame.size.height);
        //第一个页面的活动指示器
            [C_DataHandle hiddenHubAndView:_hubView];

//----------------------------------------------------------------
        NSArray *array = dic1[@"waypoints"];
        NSMutableArray  *nArray = [NSMutableArray arrayWithCapacity:10];
        for (NSDictionary *dict in array) {
            DetailTravel *detailTra  = [[[DetailTravel alloc]init]autorelease];
            [detailTra setValuesForKeysWithDictionary:dict];
                NSDictionary *dic2 = dict[@"photo_info"];
                [detailTra setValuesForKeysWithDictionary:dic2];
                NSDictionary *dic3 = dict[@"poi"];
              [detailTra setValue:dic3[@"name"] forKey:@"name"];
            [nArray addObject:detailTra];
            
            NSDictionary *dic4 = dict[@"location"];
            LocationPoint *location = [[[LocationPoint alloc]init]autorelease];
            [location setValuesForKeysWithDictionary:dic4];
            [location setValue:dic3[@"name"] forKey:@"title"];
            [self.locationArray addObject:location];

        }

        [self.modelArray addObject:nArray];
        
    }
    NSDictionary *dic5 =  dic[@"user"];
    NSInteger m = [dic5[@"id"] integerValue];
    self.id2 = m;

}


//解析得到区抬头的标题
-(NSMutableArray *)sectionArray
{
    if (_sectionArray == nil) {
        
        _sectionArray = [[NSMutableArray alloc]init];
        
    }
    return [_sectionArray retain];
}


-(void)getSectionArrayByUrlString:(NSString *)string
{
    NSString *str=[NSString stringWithFormat:@"http://api.breadtrip.com/trips/%@/waypoints/?target_type=3&target_id=12&sign=571fb52843d48c8d39cce1c592b26d05",string];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    从URL获取json数据
    AFJSONRequestOperation *operation3 = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary* JSON) {
      //   NSLog(@"获取到的数据为：%@",JSON);
        self.likeLabel.text = [NSString stringWithFormat:@"%@分享",JSON[@"shared"]];
        self.daysLabel.text =[NSString stringWithFormat:@"%@天",JSON[@"day_count"]];
        self.dateLabel.text = JSON[@"last_day"];
        self.titleLabel.text = JSON[@"name"];

      for (NSDictionary  *dic1 in JSON[@"days"]) {
            // NSLog(@"%@",dic1);
            SectionHead *sec  = [[[SectionHead alloc]init]autorelease];
            [sec setValuesForKeysWithDictionary:dic1];
                   [self.sectionArray addObject:sec];
      }
        static int a = 0;
        if (a == 0) {
            [self.tableView reloadData];
            a++;
        }
        //开始就跳到第二个页面
        self.scrollView.contentOffset = CGPointMake( 0,self.view.frame.size.height);
        //第一个页面的活动指示器
        static int b = 0;
        if (b == 0) {
            [C_DataHandle hiddenHubAndView:_hubView];
            b++;
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id data) {
        NSLog(@"解析得到头标题数据时发生错误！%@",error);
    }];
    [operation3 start];
}


#pragma -mark 获取前面的非tableView里的数据
-(void)getData1WithString:(NSString *)string
{
    NSString *str=[NSString stringWithFormat:@"http://api.breadtrip.com/trips/%@/waypoints/?target_type=3&target_id=12&sign=571fb52843d48c8d39cce1c592b26d05",string];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation1 = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary* JSON) {
        self.likeLabel.text = [NSString stringWithFormat:@"%@分享",JSON[@"shared"]];
        self.daysLabel.text =[NSString stringWithFormat:@"%@天",JSON[@"day_count"]];
        self.dateLabel.text = JSON[@"last_day"];
        self.titleLabel.text = JSON[@"name"];

       DetailTravel *detailTra = [C_DataHandle dataWithDic:JSON];
        
        [self LabelWithTextByDetailTravel:detailTra];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id data) {
        NSLog(@"非tableView数据时，发生错误！%@",error);
    }];
    [operation1 start];
}

-(void)LabelWithTextByDetailTravel:(DetailTravel *)detailTra
{

    
    self.cityLabel.text = detailTra.city;
    self.milesLabel.text = [NSString stringWithFormat:@"%ld km",detailTra.mileage];
    self.fightLabel.text =[NSString stringWithFormat:@"%ld班机",detailTra.flight];
    self.sightLabel.text = [NSString stringWithFormat:@"%ld景点",detailTra.sights];
    self.mallLabel.text = [NSString stringWithFormat:@"%ld超市",detailTra.mall];
    self.hotelLabel.text = [NSString stringWithFormat:@"%ld旅馆",detailTra.hotel1];
    [self.smallHeadPhotoImageView sd_setImageWithURL:[NSURL URLWithString:detailTra.avatar_l] placeholderImage:[UIImage imageNamed:@"1"]];
    [ self.mapImageView sd_setImageWithURL: [NSURL URLWithString:detailTra.trackpoints_thumbnail_image]];

    
}


#pragma -mark  tableView的代理方法
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailTableCell   *cell = [self.tableView dequeueReusableCellWithIdentifier:@"dCell" forIndexPath:indexPath];
    DetailTravel *detailTra = self.modelArray[indexPath.section][indexPath.row];
    cell.detailTra = detailTra;

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array  = self.modelArray[section];
    return array.count;
}



//分区个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.modelArray.count;
}


//头标题高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70;
}

//头标题设置
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SectionHead *sec = self.sectionArray[section];
    NSString *str = [NSString stringWithFormat:@"  ——————  第%ld天  ——————  ",sec.day];
    UIView *header = [[[UIView alloc]initWithFrame:CGRectMake(10, 10, tableView.frame.size.width-30, 60)]autorelease];
    header.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0.9];
    UILabel *label1 = [[[UILabel alloc]initWithFrame:CGRectMake(10, 25, tableView.frame.size.width-30, 20)]autorelease];
    label1.text = str;
    label1.textColor = [UIColor brownColor];
    label1.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    label1.textAlignment = NSTextAlignmentCenter;
    [header addSubview:label1];
    return header;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PicTravelViewController *picVC = [[[PicTravelViewController alloc]init]autorelease];
    DetailTravel *detail = self.modelArray[indexPath.section][indexPath.row];
    picVC.urlString = detail.photo;
    picVC.picArray = self.modelArray[indexPath.section];

    picVC.PicNumber = indexPath.row;
    [self.navigationController pushViewController:picVC animated:YES];
}




//***************************************************************




#pragma -mark 滑动显示隐藏nav bar
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.h1 = scrollView.contentOffset.y;
}



#pragma -mark scrollView的代理方法，隐藏导航栏
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.h2 = scrollView.contentOffset.y;
    if (self.h2  > self.h1 ) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        if (scrollView.contentOffset.y < 600) {
        }else{
        }
        
        
    }else{

        if (scrollView.contentOffset.y>0) {
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }else{
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
    }
    
}





//隐藏tabBar，暂时不可用
- (void) hideTabBar:(BOOL) hidden
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    
    for(UIView *view in self.tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+49, view.frame.size.width, view.frame.size.height)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-49, view.frame.size.width, view.frame.size.height)];
            }
        }

    }
    
    [UIView commitAnimations];
}


#pragma -mark 导航栏button方法
//地图

- (IBAction)bigMap:(id)sender {
    MapViewController *mapVC = [[[MapViewController alloc]init]autorelease];
    [self.navigationController pushViewController:mapVC animated:YES];
    mapVC.hidesBottomBarWhenPushed = YES;
    mapVC.locationArray = self.locationArray;
}


//个人页面
- (IBAction)selfHeadAction:(id *)sender {
    SelfViewController *selfVc = [[[SelfViewController alloc]init]autorelease];
    selfVc.userID = self.id2;
    [self.navigationController pushViewController:selfVc animated:YES];
    
    //隐藏导航栏
    [selfVc.navigationController setNavigationBarHidden:YES];
    //隐藏bottomBar
    selfVc.hidesBottomBarWhenPushed = YES;
}

//线路日程
- (IBAction)goToLine:(id)sender {
    NSArray *array = self.navigationController.viewControllers;
    NSInteger r = array.count;
    if ( [array[r-2] isKindOfClass:[RecommendViewController class]]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    LineViewController *lineVC  = [[[LineViewController alloc]init]autorelease];
    [self.navigationController pushViewController:lineVC animated:YES];
    lineVC.hidesBottomBarWhenPushed = YES;
    lineVC.lineID = self.tra.id1;
    NSLog(@"lineID = %ld",lineVC.lineID);
}

//返回主页
-(void)goHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


//分享
-(void)shareAction
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:ShareKey shareText:self.tra.name shareImage:[UIImage imageNamed:@"UMS_douban_icon"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren, UMShareToDouban, UMShareToEmail, UMShareToSms,  nil] delegate:nil];
}
//动画
-(void)leftRightChange
{
    if (self.scrollView.contentOffset.y == 0) {
        self.scrollView.contentOffset = CGPointMake( 0,self.view.frame.size.height);
    }else{
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
    [C_DataHandle changeView:self.tableView andView:self.DetailHeadView inSuperView:self.scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
   // self.tableView.delegate = nil;
   // self.tableView.dataSource = nil;
    [_tra release];
    
    [_smallHeadPhotoImageView release];
    [_likeLabel release];
    [_daysLabel release];
    [_dateLabel release];
    [_titleLabel release];
    
    [_cityLabel release];
    [_milesLabel release];
    [_sightLabel release];
    [_fightLabel release];
    [_mallLabel release];
    [_hotelLabel release];
    
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
        view = nil;
    }
    [_tableView release];
    [_scrollView release];
    [_DetailHeadView release];
    [_DetailView2 release];
//    [_webView release];
    
    [_viewWidth release];
    [_secondViewLeading release];
    
    [_hud release];
    [_sectionArray release];
    [_modelArray release];
    
    [_locationArray release];
    [_location release];
    [_travelID release];
    
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    
//    self.webView.delegate = nil;


    [_mapImageView release];
    [super dealloc];
    NSLog(@"detailTravelViewController的dealloc方法执行");
}
@end
