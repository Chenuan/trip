//
//  LineCell.h
//  Trip1
//
//  Created by ccyy on 15/7/1.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "DayLine.h"

@interface LineCell : BaseTableViewCell
@property (retain, nonatomic) IBOutlet UILabel *datelabel;
@property (retain, nonatomic) IBOutlet UILabel *addressLabel;

@property (nonatomic,retain) DayLine *dayline;
@end
