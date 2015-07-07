//
//  LeftViewController.m
//  Trip1
//
//  Created by ; on 15/6/20.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "LeftViewController.h"
#import "DomesticCityData.h"
#import "DomesticCity.h"
#define XJHWidth ([[UIScreen mainScreen] bounds].size.width)
#define XJHHeight ([[UIScreen mainScreen] bounds].size.height - 64 - 49)
#import "YRSideViewController.h"
#import "AppDelegate.h"
@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    DomesticCityData *data;
}
@property (nonatomic, retain) UITableView *leftTableView;

@end

@implementation LeftViewController
- (void)dealloc
{
    [_leftTableView release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self backImage];
    

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 67, 3*XJHWidth/5, 40)];
    label.text = @"国内城市";
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    [label release];
    
    
    self.leftTableView = [[[UITableView alloc]initWithFrame:CGRectMake(15, 67 + 40, 3*XJHWidth/5, XJHHeight-XJHHeight/20 - 40) style:UITableViewStylePlain] autorelease];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource =self;
    [self.view addSubview:_leftTableView];
    self.leftTableView.backgroundColor = [UIColor clearColor];
    data = [DomesticCityData shareInstance];
    self.leftTableView.rowHeight = 80;
    self.leftTableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data.domesticCityKeys.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId]autorelease];
#warning 取消cell的选中状态
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        
    }
    cell.textLabel.text = data.domesticCityKeys[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    YRSideViewController *sideView = app.sideViewController;
    [sideView hideSideViewController:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   //数据保存
    NSString *cityName = data.domesticCityKeys[indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:@"cityName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
     //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationCityName" object:nil userInfo:@{@"city":cityName}];
    
}

-(void)backImage{
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImage.image = [UIImage imageNamed:@"LeftPic.jpg"];
    //    backImage.alpha = 0.5;
    backImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backImage];
    [backImage release];
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
