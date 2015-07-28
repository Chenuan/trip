//
//  SceneDetailHeaderView.h
//  Trip1
//
//  Created by lanou on 15/6/23.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseImageView.h"
@interface SceneDetailHeaderView : UIView
@property (nonatomic,retain) NSString *imageUrlString;
@property (nonatomic,retain) BaseImageView *imgView;
@property (nonatomic,retain) UIButton *photosButton;
+(CGFloat)sceneDetailHeaderHeight;
+(CGFloat)sceneDetailHeaderImageViewHeight;
@end
