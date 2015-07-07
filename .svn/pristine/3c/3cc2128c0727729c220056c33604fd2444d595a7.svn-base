//
//  LineViewController.m
//  Trip1
//
//  Created by ccyy on 15/6/29.
//  Copyright © 2015年 kevin. All rights reserved.
//

#import "LineViewController.h"
#import "AFHTTPRequestOperation.h"
#import "DayLine.h"
#import "LineCell.h"
#import "RecommendViewController.h"
#import "C_DataHandle.h"
#import "MBProgressHUD.h"


@interface LineViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UIAlertView *_alert;
   // UIImageView *_view;
}
@property (nonatomic,retain) NSMutableArray *lineArray;

@end

@implementation LineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //  _view = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
  //  [C_DataHandle addView:_view HubToView:self.view];
    //NSLog(@"----------");
    _tableView = [[[UITableView alloc]initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds .size.width, [UIScreen mainScreen].bounds .size.height) style:UITableViewStylePlain]autorelease];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    //xib TableViewCell注册
    [_tableView registerNib:[UINib nibWithNibName:@"View" bundle:nil] forCellReuseIdentifier:@"lCell"];
    [self getData];
}
-(NSMutableArray *)lineArray
{
    if (_lineArray == nil) {
        _lineArray = [[NSMutableArray alloc]initWithCapacity:10];
        
    }
    return _lineArray;
}

#pragma -mark 代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 //   NSLog(@"**************array.count = %ld",self.lineArray.count);
    return self.lineArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     // NSLog(@"=++++++++++++++++");

    LineCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"lCell" forIndexPath:indexPath];
    DayLine *dayline = self.lineArray[indexPath.row];
    cell.dayline = dayline;
        return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 200;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DayLine *dayline = self.lineArray[indexPath.row];
    RecommendViewController *rvc = [[[RecommendViewController alloc]init]autorelease];
    //首先读取studentInfo.plist中的数据
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSDictionary *dictionary = [[[NSDictionary alloc] initWithContentsOfFile:plistPath]autorelease];
    for (NSString *key in dictionary) {
        if ([dayline.name isEqualToString:key]) {
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationCityName" object:nil userInfo:@{@"city":dayline.name}];
            [self.navigationController pushViewController:rvc animated:YES];
            rvc.h1 =  [UIScreen mainScreen].bounds.size.height-49;
            return;
        }
    }
    _alert = [[UIAlertView alloc]initWithTitle:@"抱歉" message:@"该城市数据暂未开放" delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [_alert show];
   
     NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(hiddenAlertView:) userInfo:nil repeats:NO ];
    [timer setFireDate:[NSDate distantPast]];
}
-(void)hiddenAlertView:(NSTimer  *)timer
{
    [_alert dismissWithClickedButtonIndex:0 animated:NO];
     [_alert release];
    [timer setFireDate:[NSDate distantFuture]];
    timer = nil;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getData
{
//    NSLog(@"wwwwww");
    NSString *str = [NSString stringWithFormat:@"http://api.breadtrip.com/trips/%ld/schedule/",self.lineID];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [ NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation1 = [[[AFHTTPRequestOperation alloc]initWithRequest:request]autorelease];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = operation1.responseString;
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in array) {
            DayLine *dayline = [[[DayLine alloc]init]autorelease];
            [dayline setValuesForKeysWithDictionary:dic];
            NSArray *array1 = dic[@"places"];
            for (NSDictionary *dic1 in array1) {
                NSDictionary *dic2 = dic1[@"place"];
                [dayline setValuesForKeysWithDictionary:dic2];
//                NSArray *array2 = dic1[@"pois"];
//                for (NSDictionary *dic3 in array) {
//                    dic3[@"name"]
             //   }
               // NSLog(@"dayline.name = %@",dayline.name);
                [MBProgressHUD hideHUDForView:self.view animated:YES];
              //  [C_DataHandle hiddenHubAndView:_view];
               // [_view release];
            }
            [self.lineArray addObject:dayline];
        }
   //      NSLog(@"linearray = %@",self.lineArray);
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络请求失败");
    }];
    
    NSOperationQueue *queue = [[[NSOperationQueue alloc]init]autorelease];
    [queue addOperation:operation1];
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
