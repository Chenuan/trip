//
//  FoodListViewController.m
//  Trip1
//
//  Created by lanou on 15/6/23.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "FoodListViewController.h"
#import "UIScrollView+PullScale.h"
#import "UIImageView+WebCache.h"
#import "FoodModel.h"
#import "EnabelLeftOrRIght.h"
#import "FoodPicViewController.h"
#import "FoodListViewCell.h"
#import "FoodMapViewController.h"
#import "UMSocial.h"
#define ShareKey @"5590ae1b67e58ecca200062b"
#define XJHWidth ([[UIScreen mainScreen] bounds].size.width)
#define kImageWidth self.view.bounds.size.width
#define kImageHeight kImageWidth * 0.625
/*
 推进隐藏tarBar后要设置 UITableView的Frame 就是我上面的 #define XJHHeight 要去掉49
 */
#define XJHHeight ([[UIScreen mainScreen] bounds].size.height)

@interface FoodListViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate>
{
    FoodListViewCell *cell;
    UIButton *button;
    UIButton *photosButton;

}
@property (nonatomic, retain) UITableView *foodListTableView;
@property (nonatomic,retain) UIView *navigationView;
@property (nonatomic, retain) UIImageView *headImageView;

@end

@implementation FoodListViewController
- (void)dealloc
{

    NSLog(@"....foodList release");
//#warning 在这个时候要将其代理取消 否则会出现 [FoodListViewController scrollViewDidScroll:]: message sent to deallocated instance 0x144daee40
    self.foodListTableView.delegate = nil;
    [_model release];
    [_headImageView release];
    [_navigationView release];
    [_foodListTableView release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tableView
    self.foodListTableView =[[[UITableView alloc]initWithFrame:CGRectMake(0, 0, XJHWidth, XJHHeight) style:UITableViewStylePlain] autorelease];
    self.foodListTableView.backgroundColor = BackgroundColor;
    [self.view addSubview:_foodListTableView];
    self.foodListTableView.delegate =self;
    self.foodListTableView.dataSource = self;
    //去除最cell最低端的分割线
    UIView *footViewnil = [[UIView alloc] initWithFrame:CGRectZero];
    [_foodListTableView setTableFooterView:footViewnil];
    [footViewnil release];

    //通过传值得到heard的图片URL
    NSString *imageUrl = [self.model.cover_s stringByReplacingOccurrencesOfString:@"?imageView/1/w/280/h/280/q/75" withString:@""];
    
    //头部放大的图片 第三方
//    [self.foodListTableView addPullScaleFuncInVC:self imgName:imageUrl originalHeight:200 hasNavBar:NO];
    /*****************/
    //2.创建一个ImageView
    self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -kImageHeight, kImageWidth, kImageHeight)];
    self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
    //赋值到imageView
     [self.headImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    //3.把imageview作为子视图放到tableview的首位
    [self.foodListTableView insertSubview:_headImageView atIndex:0];
    //4.设置tableView的内边距，让cell下移动imageView高度的一半
    self.foodListTableView.contentInset = UIEdgeInsetsMake(kImageHeight, 0, 0, 0);
    self.foodListTableView.contentOffset =CGPointMake(0, -kImageHeight);
    [self addMyNavAndButton];
    
    self.headImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchMe:)];

    [_headImageView addGestureRecognizer:tap];
   
    
    }
-(void)addMyNavAndButton
{
    //设置UIView的作为导航栏
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, XJHHeight, 64)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navi.png"]];
    view.alpha= 0;
    self.navigationView = view;
    
    //重新设置系统自带的右侧手势退出功能
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    //设置返回按钮
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 25, 30, 30);
    [button setImage:[UIImage imageNamed:@"back_white_colour"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(touchMe:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //设置分享按钮
    UIButton *buttonShare = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonShare.frame = CGRectMake(self.view.bounds.size.width-40, 25, 30, 30);
    [buttonShare setImage:[UIImage imageNamed:@"iconfont-fenxiang"] forState:UIControlStateNormal];
    [buttonShare addTarget:self action:@selector(shareMe) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonShare];
    [view release];
    
    photosButton = [[UIButton alloc] initWithFrame:CGRectMake(XJHWidth-40,-30, 32, 32)];
    [photosButton setImage:[UIImage imageNamed:@"photos.png"] forState:UIControlStateNormal];
    [self.foodListTableView insertSubview:photosButton atIndex:1];
    [photosButton addTarget:self action:@selector(touchMe:) forControlEvents:UIControlEventTouchUpInside];
    
    

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGPoint point = scrollView.contentOffset;
//    
//    if (point.y > 0) {
//        self.navigationView.alpha = 1;
//    }
//    else
//    {
//        self.navigationView.alpha = (point.y + 100) / 100.0;
//    }
    
    if (scrollView.contentOffset.y > - kImageHeight) {
        return;
    }
    CGFloat down = 3 * (-kImageHeight - scrollView.contentOffset.y);
    CGFloat scale = 1 + down / kImageHeight;
    self.headImageView.frame = CGRectMake(- down / kImageHeight * kImageWidth / 2, - kImageHeight * scale, kImageWidth * scale, kImageHeight * scale);
    
}
-(void)pushFoodPicViewController
{
    FoodPicViewController *foodPic = [[FoodPicViewController alloc]init];
    foodPic.url = self.model;
    [self.navigationController pushViewController:foodPic animated:YES];
    [foodPic release];

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
     CGPoint point = scrollView.contentOffset;
    NSLog(@"%g",point.y);
    if (point.y < -300) {
        [self pushFoodPicViewController];
    }
}
-(void)touchMe:(UIButton *)object
{
    if (object == button) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
         [self pushFoodPicViewController];
    }
}
-(void)shareMe
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:ShareKey shareText:@"#我爱包子旅游，我爱分享！#" shareImage:[UIImage imageNamed:@"iconfont-jikediancanicon36"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren, UMShareToDouban, UMShareToEmail, UMShareToSms,  nil] delegate:nil];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [EnabelLeftOrRIght setSideViewEnabelSwip:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [EnabelLeftOrRIght setSideViewEnabelSwip:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellId = @"Cell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FoodListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        //取消选中状态
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (indexPath.row) {
        case 1:
            cell.foodTitleLabel.text = @"概况";
            cell.foodListLabel.text = self.model.mDescription;
            break;
        case 2:
            cell.foodTitleLabel.text = @"地址";
            cell.foodListLabel.text = self.model.address;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
          
            break;
        case 3:
            cell.foodTitleLabel.text = @"联系方式";
            cell.foodListLabel.text = self.model.tel;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 0:
            [cell setViewHiden:NO];
            cell.model = self.model;
            break;
        default:
            break;
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 200;
            break;
        case 1:
            return [FoodListViewCell cellHight:self.model.mDescription];
            break;
        case 2:
            return [FoodListViewCell cellHight:self.model.address];
            break;
        case 3:
            return [FoodListViewCell cellHight:self.model.tel];
            break;
       
        default:
            break;
    }
   
    
    return -1;
}
-(void)tableView:( UITableView *)tableView didSelectRowAtIndexPath:( NSIndexPath *)indexPath
{
    
    if (indexPath.row == 2) {
         FoodMapViewController *foodMap = [[FoodMapViewController alloc]init];
        foodMap.mapModel = self.model;
        [self.navigationController pushViewController:foodMap animated:YES];
        [foodMap release];
        
    }
    
    //选中联系方式的时候跳转到 UIAlertView 并执行 UIAlertView 的代理方法
    if (indexPath.row == 3) {
        UIAlertView *callView = [[UIAlertView alloc]initWithTitle:nil message:self.model.tel delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
        [callView show];
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
#pragma -mark懒加载
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
