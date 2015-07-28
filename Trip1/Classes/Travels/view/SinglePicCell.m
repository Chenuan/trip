//
//  SinglePicCell.m
//  Trip1
//
//  Created by ccyy on 15/7/6.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "SinglePicCell.h"
#import "BaseImageView.h"

@implementation SinglePicCell

-(void)dealloc
{
    [_imageView2 release];
    [super dealloc];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.imageView2 =[[[BaseImageView alloc] initWithFrame:[[UIScreen mainScreen]bounds]]autorelease] ;
        
        self.imageView2.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imageView2];
        
        //这里是保存图片手势
        self.imageView2.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [self.imageView2 addGestureRecognizer:longPress];
        longPress.minimumPressDuration = 1;
        
        //  NSLog(@"加了一个手势到cell上");
        
    }
    return self;
    
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
