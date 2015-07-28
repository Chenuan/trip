//
//  SceneDetailTableViewCell.h
//  Trip1
//
//  Created by lanou on 15/6/23.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SceneDetailTableViewCell : UITableViewCell
@property (nonatomic,retain) NSString *model;
@property (nonatomic,retain) UILabel *titleLabel;
+(CGFloat)rowHeightBycontent:(NSString *)content;
@end

