//
//  RightDetailViewController.m
//  Trip1
//
//  Created by lanou on 15/7/3.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "RightDetailViewController.h"
#import "LGJHeader.h"
@interface RightDetailViewController ()

@end

@implementation RightDetailViewController
-(void)dealloc
{
    [_context release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LGJWidth, 64)];
    navigationView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navi.png"]];
    [self.view addSubview:navigationView];
    [navigationView release];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(10, 20, 44, 44);
    [back setImage:[UIImage imageNamed:@"back_white_colour.png"] forState:UIControlStateNormal];
    [self.view addSubview:back];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];

}
-(void)back:(UIButton *)btn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
