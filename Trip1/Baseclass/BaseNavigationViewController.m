//
//  BaseNavigationViewController.m
//  Trip1
//
//  Created by lanou on 15/6/20.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "FoodListViewController.h"


@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


  [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navi.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.tintColor = [UIColor grayColor];

  [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBar"] forBarMetrics:UIBarMetricsDefault];
//    self.navigationBar.tintColor = [UIColor grayColor];
//    self.navigationBar.backgroundColor = [UIColor colorWithRed:60.0/255.0 green:181.0/255.0 blue:44.0/255.0 alpha:1];

    self.navigationBar.translucent = NO;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};

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
