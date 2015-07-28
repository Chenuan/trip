//
//  RightDetailViewController.m
//  Trip1
//
//  Created by lanou on 15/7/3.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "RightDetailViewController.h"
#import "LGJHeader.h"
#define XJHWidth ([[UIScreen mainScreen] bounds].size.width)
#define XJHHeight ([[UIScreen mainScreen] bounds].size.height)
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
    NSLog(@"%@",self.context);
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
    if ([self.context isEqualToString:@"免责声明"]) {
        [self View1];
    }else if ([self.context isEqualToString:@"关于我们"]){
        [self View2];

    }
}
-(void)View1
{
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, XJHWidth*0.9, XJHHeight)];

    title.numberOfLines = 0;
    [self.view addSubview:title];
    title.text = @"  本app所有内容,包括文字、图⽚、⾳频、视频、软件、程序、以及版式设计等均在网上搜集。\n\n  访问者可将本app提供的内容或服务⽤于个⼈学习、研究或欣赏,以及其他非商业性或非盈利性用途,但同时应遵守著作权法及其他相关法律的规定,不得侵犯本app及相关权利人的合法权利。除此以外,将本app任何内容或服务⽤于其他用途时,须征得本app及相关权利人的书面许可,并支付报酬。\n\n  本app内容原作者如不愿意在本app刊登内容,请及时通知本app,予以删除。 \n\n  电子邮箱:chenhuaizhe@gmail.com";
}
-(void)View2
{
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, XJHWidth*0.9, XJHHeight)];
    
    title.numberOfLines = 0;
    [self.view addSubview:title];
    title.text = @"  Powered By：徐杰鸿，廖广军，陈源 \n\n  请联系：chenhuaizhe@gmail.com";
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
