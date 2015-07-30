//
//  TraCollectionViewCell.h
//  Trip1
//
//  Created by ccyy on 15/6/29.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "BaseImageView.h"

@interface TraCollectionViewCell : BaseCollectionViewCell
@property (nonatomic,retain) BaseImageView *image_view;
@property (nonatomic,retain) UILabel *cTitleLabel;

@end
