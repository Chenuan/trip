//
//  SceneDetailTableViewCell.m
//  Trip1
//
//  Created by lanou on 15/6/23.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "SceneDetailTableViewCell.h"

#import "LGJHeader.h"


@interface SceneDetailTableViewCell()
@property (nonatomic,retain) UILabel *detailLabel;
@end

@implementation SceneDetailTableViewCell

-(void)dealloc{
    [_titleLabel release];
    [_detailLabel release];
    [_model release];
    [super dealloc];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, LGJWidth - 20, 40)];
        
        [self.contentView addSubview:label];
        label.font = [UIFont systemFontOfSize:17];
        [label release];
        self.titleLabel = label;
        
        UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, LGJWidth - 20, 40)];
        [self.contentView addSubview:detail];
        self.detailLabel = detail;
        detail.font = [UIFont systemFontOfSize:14];
        detail.numberOfLines = 0;
        [detail release];
        self.backgroundColor = LGJBackgroundColor;
    }
    return self;
}

+(CGFloat)rowHeightBycontent:(NSString *)content
{
    CGFloat height = [self heightBycontent:content];
    
    //没有内容的时候返回的高度为0
    if (content.length == 0) {
        return 0;
    }
    
    return height + 40 + 10;
}
+(CGFloat)heightBycontent:(NSString *)content{
    CGRect rect = [content boundingRectWithSize:CGSizeMake(LGJWidth - 20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    return rect.size.height;
}
-(void)setModel:(NSString *)model
{
    if (_model != model) {
        [_model release];
        _model = [model copy];
    }
    
    if (model.length == 0) {
        self.titleLabel.bounds = CGRectMake(0, 0, 0, 0);
        self.titleLabel.textColor = [UIColor clearColor];
    }
    
    
    self.detailLabel.frame = CGRectMake(self.detailLabel.frame.origin.x,self.detailLabel.frame.origin.y, self.detailLabel.frame.size.width, [[self class] heightBycontent:model]);
    self.detailLabel.text = model;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
