//
//  RightViewController.m
//  Trip1
//
//  Created by lanou on 15/6/20.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "RightViewController.h"
#import "LGJHeader.h"
#import "AppDelegate.h"
#import "YRSideViewController.h"
#import "RightDetailViewController.h"
#import "BaseNavigationViewController.h"
#import "SDImageCache.h"
@interface RightViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tabel;
}
@property (nonatomic,retain) NSMutableArray *array;
@end

@implementation RightViewController

-(void)dealloc
{
    [_array release];
    [super dealloc];
}

-(NSMutableArray *)array
{
    if (_array == nil) {
        _array = [[NSMutableArray alloc] initWithArray:@[@"关于我们",@"清除缓存",@"免责声明",@"返回"]];
    }
    return [[_array retain] autorelease];
}
-(void)viewWillAppear:(BOOL)animated
{
    [tabel reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImage.image = [UIImage imageNamed:@"RightPic.jpeg"];
    //    backImage.alpha = 0.5;
    
    
    backImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backImage];
    [backImage release];
    // Do any additional setup after loading the view.
    [self creatTabelView];
    
}
-(void)creatTabelView
{

    tabel = [[UITableView alloc] initWithFrame:CGRectMake(160,64, LGJWidth * 0.6, LGJHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:tabel];
    tabel.backgroundColor = [UIColor clearColor];
    tabel.delegate = self;
    tabel.dataSource = self;
    [tabel release];
//    [tabel registerClass:[UITableViewCell class] forCellReuseIdentifier:@"leftCell"];
    tabel.rowHeight = 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        
    }
    cell.textLabel.text = self.array[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row == 1) {
        cell.detailTextLabel.text = [self getSize];
        cell.detailTextLabel.textColor = cell.textLabel.textColor;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        

    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger row = indexPath.row;
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    YRSideViewController *sideView = app.sideViewController;
    if (row == 3) {
        
        [sideView hideSideViewController:YES];
    }
    else if(row == 1)
    {
        
//        [[SDImageCache sharedImageCache] cleanDiskWithCompletionBlock:^{
//           
//            
//            
//        }];
        
        [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
            NSLog(@"%@",[self getSize]);
            UITableViewCell *cell1 = [tableView cellForRowAtIndexPath:indexPath];

            cell1.detailTextLabel.text = [self getSize];
        }];
    }
    else
    {
        RightDetailViewController *rightDetail = [[RightDetailViewController alloc] init];
        rightDetail.context = self.array[row];
        [self presentViewController:rightDetail animated:YES completion:^{
            [sideView hideSideViewController:YES];
        }];
        [rightDetail release];
    }
}
-(NSString *)getSize
{
    NSInteger size = [[SDImageCache sharedImageCache] getSize];
    
    //        NSLog(@"%ld",size);
    NSString *unit = @"B";
    CGFloat sizeFormater = 0;
    if (size > 1024 * 1024) {
        sizeFormater = (size * 1.0) / 1024 /1024;
        unit = @"M";
    }
    else if(size >  1024)
    {
        sizeFormater = size * 1.0/1024;
        unit = @"KB";
    }
    else{
        sizeFormater = size;
        unit = @"B";
    }
    
    NSString *sizeString = [NSString stringWithFormat:@"%.2f%@",sizeFormater,unit];
    
    NSLog(@"%@",sizeString);
    return sizeString;
    
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
