//
//  photoView.m
//  Trip1
//
//  Created by lanou on 15/6/25.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "photoView.h"
#import "LGJHeader.h"
@implementation photoView

-(instancetype)init
{
    if (self = [super init]) {
        
        self.frame = [[UIScreen mainScreen] bounds];
        self.backgroundColor = [UIColor blackColor];
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 20;
        flowLayout.minimumInteritemSpacing = 20;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 20);
        flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width + 20, self.frame.size.height ) collectionViewLayout: flowLayout];
        [self addSubview:collection];
        self.collectionView = collection;
        
        
        collection.pagingEnabled = YES;
        [collection release];
        [flowLayout release];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 44, 44)];
        [btn setImage:[UIImage imageNamed:@"back_white_colour.png"] forState:UIControlStateNormal];
        [self addSubview:btn];
        self.leftButton = btn;
        [btn release];
        
    }
    
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
