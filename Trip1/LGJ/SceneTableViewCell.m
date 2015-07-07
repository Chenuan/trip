//
//  SceneTableViewCell.m
//  Trip1
//
//  Created by lanou on 15/6/22.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "SceneTableViewCell.h"
#import "LGJHeader.h"
#import "UIImageView+WebCache.h"
#define CellDistance (LGJWidth * 0.04)
#define CellDistanceHeight (LGJSceneRowHeight * 0.04)
@interface SceneTableViewCell ()
@property (nonatomic,retain) UIImageView *imageV;
@property (nonatomic,retain) UILabel *nameLabel;

@end
@implementation SceneTableViewCell
-(void)dealloc{
    [_imageV release];
    [_nameLabel release];
    [_model release];
    [super dealloc];
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *containView = [[UIView alloc] initWithFrame:CGRectMake(CellDistance / 2, CellDistanceHeight / 2, LGJWidth -CellDistance,LGJSceneRowHeight - CellDistanceHeight)];
        [self.contentView addSubview:containView];
        [containView release];
        
        UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, containView.frame.size.width, containView.frame.size.height)];
        [containView addSubview:imgv];
        self.imageV = imgv;
        
        imgv.layer.masksToBounds = YES;
        imgv.layer.cornerRadius = 8;
        [imgv release];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10,imgv.frame.size.height - 40,imgv.frame.size.width,40)];
        [containView addSubview:label];
        self.nameLabel = label;
        label.textColor = [UIColor colorWithWhite:1 alpha:1];
        label.font = [UIFont systemFontOfSize:16];
        
        [label release];
        self.backgroundColor = LGJBackgroundColor;
    }
    return self;
}
-(void)setModel:(SceneModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
 
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.cover_route_map_cover] placeholderImage:[UIImage imageNamed:@"place_location.png"]];
    self.nameLabel.text = model.name;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
