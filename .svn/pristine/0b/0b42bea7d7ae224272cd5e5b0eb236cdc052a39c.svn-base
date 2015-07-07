//
//  PicTravelViewController.m
//  Trip1
//
//  Created by ccyy on 15/6/29.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "PicTravelViewController.h"
#import "UIImageView+WebCache.h"
#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "TraCollectionViewCell.h"
#import "DetailTravel.h"
#import "EnabelLeftOrRIght.h"
#import "SinglePicCell.h"
#define w  self.view.frame.size.width
#define h  self.view.frame.size.height


@interface PicTravelViewController ()
{

    UICollectionView *_picCollectionView;
//    UIActivityIndicatorView *_activityIndedicator;
}

@end

@implementation PicTravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"当日图片";
    // Do any additional setup after loading the view.
    
  //  [self initImageView];
    [self initCollectionView];
 //   [self initButton];
   // [self addActivityView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [EnabelLeftOrRIght setSideViewEnabelSwip:NO];
    [self.navigationController setNavigationBarHidden:NO];
    
}

/*
-(void)initButton
{
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 25, 16, 16);
    [button setImage:[UIImage imageNamed:@"iconfont-fanhui (1).png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
*/
-(void)backAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)initImageView
{
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
//    imageView.image = self.imageV.image;
//    [self.view addSubview:imageView];
//    [_imageV release];
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, XJHWidth, XJHHeight)];
    [imageView1 sd_setImageWithURL:[NSURL URLWithString:self.urlString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        {
            imageView1.image = image;
        }
    }];
    [self.view addSubview:imageView1];
   
    [imageView1 release];
}


-(void)initCollectionView
{
    _picCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, XJHWidth, XJHHeight) collectionViewLayout:[self PicListCollectionViewFlowLayout]];
    [self.view addSubview:_picCollectionView];
    
    _picCollectionView.delegate = self;
    _picCollectionView.dataSource =self;
    _picCollectionView.pagingEnabled =YES;
    
    
    _picCollectionView.contentOffset = CGPointMake(XJHWidth*self.PicNumber, XJHHeight);
    
    
    //注册
    [_picCollectionView registerClass:[SinglePicCell class] forCellWithReuseIdentifier:@"Cell"];
    
    [_picCollectionView release];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sectio
{
    NSLog(@"self.picArray.count = %lu",(unsigned long)self.picArray.count);
    return self.picArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SinglePicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
     UIActivityIndicatorView *activityIndedicator = [[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]autorelease];
    activityIndedicator.center = CGPointMake(w/2, h/2);
    [cell addSubview:activityIndedicator];
    activityIndedicator.hidesWhenStopped  = YES;
    [activityIndedicator startAnimating];

    
    DetailTravel *picModel = self.picArray[indexPath.row];
    NSURL *imageUrl = [NSURL URLWithString:picModel.photo];

    [cell.imageView2 sd_setImageWithURL:imageUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        cell.imageView2.image = image;
        [activityIndedicator stopAnimating];
        [activityIndedicator removeFromSuperview];
    }];
  //  cell.frame = CGRectMake(0,0,cell.contentView.frame.size.width, cell.contentView.frame.size.height);
 //   cell.imageView2.contentMode = UIViewContentModeScaleAspectFit;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [tap setNumberOfTapsRequired:2];
    [cell.imageView2 addGestureRecognizer:tap];
    return cell;
}

-(UICollectionViewFlowLayout *)PicListCollectionViewFlowLayout
{
    UICollectionViewFlowLayout *flowLayout = [[[UICollectionViewFlowLayout alloc]init]autorelease];
    flowLayout.itemSize = CGSizeMake(XJHWidth,XJHHeight);
    flowLayout.minimumLineSpacing = 0;
//滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return flowLayout;
    
}
-(void)tapAction:(UITapGestureRecognizer *)tapAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [EnabelLeftOrRIght setSideViewEnabelSwip:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
