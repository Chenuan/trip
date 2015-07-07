//
//  PicTravelViewController.h
//  Trip1
//
//  Created by ccyy on 15/6/29.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "BaseViewController.h"

#define XJHWidth ([[UIScreen mainScreen] bounds].size.width)
#define XJHHeight ([[UIScreen mainScreen] bounds].size.height)

@interface PicTravelViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (retain,nonatomic) NSString *urlString;
@property (nonatomic,assign) NSInteger  PicNumber;
@property (nonatomic,retain) NSArray *picArray;

@end
