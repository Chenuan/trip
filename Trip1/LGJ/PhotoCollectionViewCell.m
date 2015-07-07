//
//  PhotoCollectionViewCell.m
//  Trip1
//
//  Created by lanou on 15/6/24.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "LGJHeader.h"
#import "UIImageView+WebCache.h"
@implementation PhotoCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, LGJWaterWidth, LGJWaterWidth)];
        [self.contentView addSubview:imageV];
//        imageV.userInteractionEnabled = YES;
        imageV.backgroundColor = [UIColor whiteColor];
        self.imgv = imageV;
//        imageV.image = [UIImage imageNamed:@"place_location.png"];
        
        [imageV release];
      
    }
    return self;
}

-(void)setModel:(NSString *)model
{
    if (_model != model) {
        [_model release];
        _model = [model copy];
    }
    [self.imgv sd_setImageWithURL:[NSURL URLWithString:model] placeholderImage:[UIImage imageNamed:@"place_location.png"]];
}
@end
