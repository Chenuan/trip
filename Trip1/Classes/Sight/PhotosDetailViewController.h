//
//  PhotosDetailViewController.h
//  Trip1
//
//  Created by lanou on 15/7/2.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "BaseViewController.h"
@class SceneModel;
@interface PhotosDetailViewController : BaseViewController
@property (nonatomic,retain) NSMutableArray *photosArray;
@property (nonatomic,retain) SceneModel *model;
@property (nonatomic) CGPoint contentOffset;


@end
