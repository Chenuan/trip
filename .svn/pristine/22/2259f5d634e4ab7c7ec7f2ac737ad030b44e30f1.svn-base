//
//  SceneDetailHeaderView.m
//  Trip1
//
//  Created by lanou on 15/6/23.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "SceneDetailHeaderView.h"
#import "LGJHeader.h"
#import "UIImageView+WebCache.h"

#define headerImgvHeight ((LGJWidth / 38.0) * 24.0)
#define headerLabelHeight (40)
#define headerHeight (headerLabelHeight + headerImgvHeight)

@interface SceneDetailHeaderView()

@end

@implementation SceneDetailHeaderView

-(void)dealloc{
    [_imageUrlString release];
    [_imgView release];
    [super dealloc];
}

-(void)setImageUrlString:(NSString *)imageUrlString
{
    if (_imageUrlString != imageUrlString) {
        [_imageUrlString release];
        _imageUrlString = [imageUrlString retain];
    }
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:@"place_location.png"]];
}
-(instancetype)init
{
    self = [super init];
        if (self) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LGJWidth,headerHeight)];
            [self addSubview:view];
            [view release];
            BaseImageView *imgv = [[BaseImageView alloc] initWithFrame:CGRectMake(0, 0, LGJWidth, headerImgvHeight)];
            [view addSubview:imgv];
            [imgv release];
            self.imgView = imgv;
            imgv.userInteractionEnabled = YES;
            
            
            UIButton *photosButton = [[UIButton alloc] initWithFrame:CGRectMake(LGJWidth - 44, imgv.frame.size.height - 34, 30, 30)];
            [view addSubview:photosButton];
            [photosButton release];
            [photosButton setImage:[UIImage imageNamed:@"photos.png"] forState:UIControlStateNormal];
            self.photosButton = photosButton;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imgv.frame.size.height, LGJWidth, headerLabelHeight)];
            label.text = @"基本信息";
            label.backgroundColor = LGJBackgroundColor;
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
            [label release];
            
            self.frame = view.frame;
            
        }
        return self;
}
+(CGFloat)sceneDetailHeaderHeight{
    return headerHeight;
}
+(CGFloat)sceneDetailHeaderImageViewHeight
{
    return headerImgvHeight;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
