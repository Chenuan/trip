//
//  SelfViewController.m
//  Trip1
//
//  Created by ccyy on 15/6/29.
//  Copyright © 2015年 kevin. All rights reserved.
//

#import "SelfViewController.h"
#import "AFHTTPRequestOperation.h"
#import "UserTravel.h"
#import "CYbgCell.h"
#import "CYUserListCell.h"
#import "UIImageView+WebCache.h"
#import "EnabelLeftOrRIght.h"
#import "CYUserBgView.h"
//#import "SDImageCache.h"
//#import "SDWebImageManager.h"
//#import "SDWebImageOperation.h"

@interface SelfViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSTimer *_time;
    int num;
}
@property (nonatomic,retain) NSMutableArray *array;
@property (nonatomic,retain) CYUserBgView *bgView;



@end

@implementation SelfViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [EnabelLeftOrRIght setSideViewEnabelSwip:NO];
    [self addNewNavgationBar];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //退出页面时导航栏重新显示
    [self.navigationController setNavigationBarHidden:NO];
    //关定时器
    _time = nil;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //定时器
//    num = 1;
    
    _time = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(doWordShow) userInfo:nil repeats:YES];
    
    [_time setFireDate:[NSDate distantPast]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //左滑返回功能开启
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;

    self.array = [[[NSMutableArray alloc] initWithCapacity:10]autorelease];
    //添加tableView
    _tableView = [[[UITableView alloc]initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds .size.width, [UIScreen mainScreen].bounds .size.height) style:UITableViewStyleGrouped]autorelease];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self getData];
    
    //注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"CYUserListCell" bundle:nil] forCellReuseIdentifier:@"uCell"];
    
}

-(void)doWordShow
{
    
    NSString *str =  @"我们一直在旅行，一直在等待某个人可以成为旅途的伴侣，走过一段别人无法替代的记忆。在那里，有特有的记忆，亲情之忆、友谊之花、爱情之树、以及遗憾之泪";
    _tableView.sectionHeaderHeight = 380;
    CYUserBgView *bgView = (CYUserBgView *)[self.view viewWithTag:10001];
    bgView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 380);
    bgView.textLabel1.frame = CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width, 100);
    if (bgView.textLabel1.text != str) {
        
        bgView.textLabel1.text = [str substringToIndex:num];
        
        num++;

    }else
    {
        [_time setFireDate:[NSDate distantFuture]];
               num = 1;
    }
    
    
    
}


-(void)addNewNavgationBar
{

    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
  //  navigationView.alpha = 0;
    navigationView.backgroundColor = [UIColor clearColor];
  //  self.navigationView = navigationView;
    [self.view addSubview:navigationView];
    [navigationView release];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(10, 20, 44, 44);
    [back setImage:[UIImage imageNamed:@"iconfont-fanhui (3).png"] forState:UIControlStateNormal];
    [self.view addSubview:back];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getData
{
   
    AFHTTPRequestOperation *operation1 = [[[AFHTTPRequestOperation alloc]initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.breadtrip.com/users/%lu/v2/",self.userID]]]]autorelease];
    NSLog(@"url = %@",[NSString stringWithFormat:@"http://api.breadtrip.com/users/%lu/v2/",self.userID]);
    NSLog(@"userId = %lu",self.userID);
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = operation.responseString;
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dic ==== %@",dic);
        for (NSDictionary *dic1 in dic[@"trips"]) {
             UserTravel *user = [[[UserTravel alloc]init]autorelease];
            [user setValue:dic1[@"name"] forKey:@"travelName"];
            [user setValue:dic1[@"cover_image_w640"] forKey:@"travelPhoto"];
            [user setValue:dic1[@"id"] forKey:@"travelID"];
            [self.array addObject:user];
     //       NSLog(@"array  = %@",self.array);
        }
        NSDictionary *dic2 = dic[@"user_info"];
     //   NSLog(@"==========%@",dic[@"user_info"]);
        [self setValuesForKeysWithDictionary:dic2];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"用户页面网络请求shib");
    }];
    NSOperationQueue *queue = [[[NSOperationQueue alloc] init]autorelease];
    [queue addOperation:operation1];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
   }else{
      //  NSLog(@"**************array.count = %ld",self.array.count);
        return self.array.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  //  NSLog(@"=++++++++++++++++");
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[[UITableViewCell alloc]init]autorelease];
        
        return cell;
    }else{
     //   NSLog(@"----------------");
       // static NSString *cellIndentifier2 = @"uCell"; */
        CYUserListCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"uCell" forIndexPath:indexPath];
//        if (cell2 == nil) {
//            cell2 = [[[CYUserListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier2]autorelease];
//        }
        UserTravel  *user = self.array[indexPath.row];
        cell2.user = user;
        return cell2;
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 0;
    }else{
        return 200;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
      return 280;
   }
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        NSString * str = @"____________我的游记_____________";
        UIView *header = [[[UIView alloc]initWithFrame:CGRectMake(10, 10, tableView.frame.size.width-30, 60)]autorelease];
        header.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0.9];
        UILabel *label1 = [[[UILabel alloc]initWithFrame:CGRectMake(10, 25, tableView.frame.size.width-30, 20)]autorelease];
        label1.text = str;
        label1.textColor = [UIColor brownColor];
        label1.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
        label1.textAlignment = NSTextAlignmentCenter;
        [header addSubview:label1];
        //tableView.tableHeaderView = header;
        return header;
    }
    
    CYUserBgView *bgView = [[[CYUserBgView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 280)]autorelease];
    bgView.nameLabel.text = self.name;
    [bgView.headImageView sd_setImageWithURL:[NSURL URLWithString:self.avatar_l]];
    [bgView.bgImageView sd_setImageWithURL:[NSURL URLWithString:self.cover]];
//    NSString *str =  @"我们一直在旅行，一直在等待某个人可以成为我们旅途的伴侣，陪我们走过一段别人无法替代的记忆。在那里，有我们特有的记忆，亲情之忆、友谊之花、爱情之树、以及遗憾之泪";
//    bgView.textLabel1.text = str;
    bgView.tag = 10001;

    return bgView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UserTravel *user = self.array[indexPath.row];
//    NSLog(@"travelID = %lu",user.travelID);
// //   发送通知
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"notifacationtravelID" object:nil userInfo:@{@"travelID":[NSString stringWithFormat:@"%ld", user.travelID]}];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)dealloc
{
    [super dealloc];
    [_cover release];
    [_avatar_l release];
    [_name release];
    [_array release];
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
}

-(void)setValue:(id)value forKey:(NSString *)key
{
  //  NSLog(@"key的值 ＝ %@",key);
    if ([key isEqualToString:@"name"]) {
        self.name = value;
     //   NSLog(@"key = %@,value = %@",key,value);
    }
    if ([key isEqualToString:@"avatar_l"]) {
        self.avatar_l = value;
    }
    if ([key isEqualToString:@"cover"]) {
        self.cover = value;
    }
    
    
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
