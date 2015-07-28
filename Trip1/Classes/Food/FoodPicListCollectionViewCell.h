//
//  FoodPicListCollectionViewCell.h
//  Trip1
//
//  Created by lanou on 15/6/28.
//  Copyright © 2015年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseImageView;
@interface FoodPicListCollectionViewCell : UICollectionViewCell<UIAlertViewDelegate>
@property (nonatomic, retain) BaseImageView *imageView2;

@property (nonatomic,retain,readonly) UITapGestureRecognizer *doubleTap;

@property (nonatomic, retain) UIImage  *image;

-(void)backToNormalFrame;


@end
