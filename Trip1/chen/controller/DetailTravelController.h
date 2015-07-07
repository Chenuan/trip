//
//  DetailTravelController.h
//  Trip1
//
//  Created by ccyy on 15/6/23.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "BaseViewController.h"
#import "TravelViewController.h"
#import "TravelList.h"
#import <UIKit/UIKit.h>

@interface DetailTravelController : BaseViewController
@property  (retain,nonatomic) TravelList *tra;
@property (nonatomic,retain) NSString *travelID;

@end
