//
//  PopupView.m
//  LastRow
//
//  Created by lanou on 15/6/29.
//  Copyright (c) 2015年 Yan. All rights reserved.
//

#import "PopupView.h"
#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationFade.h"
#import "LewPopupViewAnimationSlide.h"
#import "LewPopupViewAnimationSpring.h"
#import "LewPopupViewAnimationDrop.h"
#import "SDImageCache.h"

@implementation PopupView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        self.innerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _innerView.backgroundColor = [UIColor whiteColor];
        _innerView.layer.cornerRadius = 15;
        _innerView.layer.masksToBounds = YES;
        CGFloat w = _innerView.frame.size.width;
        CGFloat h = _innerView.frame.size.height;
        [self addSubview:_innerView];
        
        UIButton *aboutUsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        aboutUsButton.frame = CGRectMake(w/4, 60, w/2, 30);
        [aboutUsButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [aboutUsButton addTarget:self action:@selector(aboutUsAction:) forControlEvents:UIControlEventTouchUpInside];
        [aboutUsButton setTitle:@"关于我们" forState:UIControlStateNormal];
        [self.innerView addSubview:aboutUsButton];

        UIButton *liabilityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        liabilityButton.frame = CGRectMake(w/4,90, w / 2, 30);
        [liabilityButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [liabilityButton addTarget:self action:@selector(liabilityAction:) forControlEvents:UIControlEventTouchUpInside];
        [liabilityButton setTitle:@"免责声明" forState:UIControlStateNormal];
        [self.innerView addSubview:liabilityButton];
        
        UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        clearButton.frame = CGRectMake(w/4,30, w / 2, 30);
        [clearButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [clearButton addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
        [clearButton setTitle:@"清除缓存" forState:UIControlStateNormal];
        [self.innerView addSubview:clearButton];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(w/4, h-50, w / 2, 20);
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(dismissViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [self.innerView addSubview:button];
    }
    return self;
}


- (void) aboutUsAction:(UIButton*)button
{
    self.innerView.frame = CGRectMake(20, 20, 150, 150);
    for (UIView *view in self.innerView.subviews) {
        [view removeFromSuperview];
    }
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10,10, 135, 135)];
    label.text = @" Powered By：徐杰鸿，廖广                                                                    军，陈源                                     联系：chenhuaizhe@gmail.com";
    label.backgroundColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:13.0];
    [self.innerView addSubview:label];
    [label release];
    
}

- (void) liabilityAction:(UIButton*)button
{
    self.innerView.frame = CGRectMake(20, 20, 150, 150);
    for (UIView *view in self.innerView.subviews) {
        [view removeFromSuperview];
    }
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10,10, 135, 135)];
    label.text = @"此APP数据皆来源于网络，特别是面包旅行的数据，仅限于交流、娱乐和学习，请勿用于商业用途。如有任何不妥，请联系我们进行处理。";
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:13.0];
    [self.innerView addSubview:label];
    [label release];
}

- (void) dismissViewAction:(UIButton*)button
{
    [_parentVC lew_dismissPopupView];
}

- (void) clearAction:(UIButton*)button
{
    //1.只清除memory的图片，下一次加载的时候本地还有，只是清除一下临时缓存
    [[SDImageCache sharedImageCache] clearMemory];
    
    UIAlertView *alert =  [[UIAlertView alloc]initWithTitle:@"提示" message:@"内存已清除" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];
    [_parentVC lew_dismissPopupView];
}


+ (instancetype) defaultPopuView
{
    return [[PopupView alloc]initWithFrame:CGRectMake(0, 0, 195, 200)];
}




@end
