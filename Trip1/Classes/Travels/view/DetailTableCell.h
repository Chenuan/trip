//
//  DetailTableCell.h
//  Trip1
//
//  Created by ccyy on 15/6/24.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "BaseTableViewCell.h"
@class DetailTravel;

@interface DetailTableCell : BaseTableViewCell
@property (nonatomic,retain) DetailTravel *detailTra;
@property (nonatomic,retain) UIImageView *pic;
@end
