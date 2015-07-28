//
//  SelfViewController.h
//  Trip1
//
//  Created by ccyy on 15/6/29.
//  Copyright © 2015年 kevin. All rights reserved.
//

#import "BaseViewController.h"

@interface SelfViewController : BaseViewController
@property (assign,nonatomic)  NSInteger userID;
@property (nonatomic,retain) NSString *name;

@property (nonatomic,retain) NSString *avatar_l;
@property (nonatomic,retain) NSString *cover;

@end
