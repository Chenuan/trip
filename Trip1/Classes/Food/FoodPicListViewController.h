//
//  FoodPicListViewController.h
//  Trip1
//
//  Created by lanou on 15/6/28.
//  Copyright © 2015年 kevin. All rights reserved.
//

#import "BaseViewController.h"
@class FoodPicModel;
typedef void (^ReturnPicArray)(NSMutableArray *arr);
@interface FoodPicListViewController : BaseViewController
@property (nonatomic, retain) FoodPicModel *PicListUrl;
@property (nonatomic, retain) NSMutableArray *picListArray;
@property (nonatomic, assign) NSUInteger PicNumber;
@property (nonatomic, retain) NSString *mID;
@property (nonatomic, copy) ReturnPicArray arrBlock;
-(void)retureArr:(ReturnPicArray)block;

@end
