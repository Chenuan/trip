//
//  FoodPicListCollectionViewCell.m
//  Trip1
//
//  Created by lanou on 15/6/28.
//  Copyright © 2015年 kevin. All rights reserved.
//

#import "FoodPicListCollectionViewCell.h"
#import "BaseImageView.h"
@interface FoodPicListCollectionViewCell ()<UIScrollViewDelegate>
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic,retain,readwrite) UITapGestureRecognizer *doubleTap;

@end


@implementation FoodPicListCollectionViewCell
-(void)dealloc
{

    [_image release];
    [_scrollView release];


    [_imageView2 release];
    [super dealloc];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        
        self.scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        self.scrollView.maximumZoomScale = 2;
        self.scrollView.minimumZoomScale = 1;
        self.scrollView.alwaysBounceVertical = NO;
        self.scrollView.delegate = self;
        [self.contentView addSubview:self.scrollView];
        
        [_scrollView release];
        

        self.imageView2 =[[[BaseImageView alloc] initWithFrame:[[UIScreen mainScreen]bounds]]autorelease] ;

        [self.scrollView addSubview:_imageView2];
        self.imageView2.contentMode = UIViewContentModeScaleAspectFit;



        
        //点击两下进入方法的手势
        self.doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        [_doubleTap setNumberOfTapsRequired:2];
        [self.contentView addGestureRecognizer:_doubleTap];
        [_doubleTap release];

        //这里是保存图片手势
        self.imageView2.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [self.imageView2 addGestureRecognizer:longPress];
        longPress.minimumPressDuration = 1;

        
        
      //  NSLog(@"加了一个手势到cell上");
        
    }
    return self;
    
}


-(void)doubleTap:(UITapGestureRecognizer *)tap
{
    CGPoint touchPoint = [tap locationInView:tap.view];
    
    
    //设置以点击的点为中心放大
    CGPoint pointInImgv = CGPointMake(touchPoint.x + self.scrollView.contentOffset.x, touchPoint.y + self.scrollView.contentOffset.y);
    CGFloat scaleX = pointInImgv.x / self.imageView2.frame.size.width;
    CGFloat scaleY = pointInImgv.y / self.imageView2.frame.size.height;
    
    
    if(self.scrollView.zoomScale == 1){
        
        CGPoint contectOffSet = CGPointMake(self.scrollView.frame.size.width * 2 * scaleX - [[UIScreen mainScreen] bounds].size.width / 2, self.scrollView.frame.size.height * 2 * scaleY - [[UIScreen mainScreen] bounds].size.height / 2);
        
        if (contectOffSet.x < 0) {
            contectOffSet.x = 0;
        }
        else if (contectOffSet.x > self.scrollView.frame.size.width * 2 - [[UIScreen mainScreen] bounds].size.width) {
            contectOffSet.x = self.scrollView.frame.size.width * 2 - [[UIScreen mainScreen] bounds].size.width;
        }
        
        if (contectOffSet.y < 0) {
            contectOffSet.y = 0;
        }
        else if (contectOffSet.y > self.scrollView.frame.size.height * 2 - [[UIScreen mainScreen] bounds].size.height) {
            contectOffSet.y = self.scrollView.frame.size.height * 2 - [[UIScreen mainScreen] bounds].size.height;
        }
        
        
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollView.zoomScale = 2;
            self.scrollView.contentOffset = contectOffSet;
            [self setScrollViewContentInset];
        }];
    }
    else{
        [UIView animateWithDuration:0.3 animations:^{
            [self backToNormalFrame];
        }];
        
    }
}
-(void)setScrollViewContentInset
{
    if (([self imageHeight]) <= [[UIScreen mainScreen] bounds].size.height) {
        self.scrollView.contentInset = UIEdgeInsetsZero;
    }
    else{
        self.scrollView.contentInset = UIEdgeInsetsMake(-(self.scrollView.contentSize.height - [self imageHeight])  * 0.5, 0, -(self.scrollView.contentSize.height - [self imageHeight])  * 0.5, 0);
    }
}
-(CGFloat)imageHeight
{
    CGFloat scaleHeight = self.imageView2.image.size.height /self.imageView2.image.size.width;
    CGFloat imageHeight = self.scrollView.frame.size.width * scaleHeight;
    return imageHeight * self.scrollView.zoomScale;
}



//-(BaseImageView *)imageView2
//{
//    if (_imageView2 == nil) {
//        _imageView2 = [[BaseImageView alloc]init];
//        [self.scrollView addSubview:_imageView2];
//    }
//    return [[_imageView2 retain]autorelease];
//}
//-(void)setImage:(UIImage *)image
//{
//    if (_image != image) {
//        [_image release];
//        _image = [image retain];
//        
//    }
//    self.imageView2.image = image;
//    [self.imageView2 sizeToFit];
//    self.scrollView.contentSize = image.size;
//
//}

-(void)backToNormalFrame
{
    self.scrollView.zoomScale = 1;
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView2;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (([self imageHeight]) <= [[UIScreen mainScreen] bounds].size.height && scrollView.zooming == NO) {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x,(self.imageView2.frame.size.height - self.scrollView.frame.size.height) /2);
    }
    
}


-(void)longPress:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        longPress.enabled = NO;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"图片" message:@"存到手机上"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存", nil];
        [alert show];
        [alert release];
    }

}
-(void)alertView:( UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    }else{
         UIImageWriteToSavedPhotosAlbum(self.imageView2.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    }
}


//实现imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:方法

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"呵呵";
    if (!error) {
        message = @"成功保存到相册";
    }else
    {
     message = [error description];
    }
    NSLog(@"message is %@",message);
}





@end

