//
//  PopupView.h
//  LastRow
//
//  Created by lanou on 15/6/29.
//  Copyright (c) 2015年 Yan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupView : UIView
@property (nonatomic,retain) UIView *innerView;
@property (nonatomic,retain) UIViewController *parentVC;

+(instancetype) defaultPopuView;
@end
