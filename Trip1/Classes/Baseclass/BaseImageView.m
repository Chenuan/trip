//
//  BaseImageView.m
//  Trip1
//
//  Created by lanou on 15/6/25.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "BaseImageView.h"

@interface BaseImageView()
@property (nonatomic,assign) id target;
@property (nonatomic,assign) SEL action;
@property (nonatomic,assign) UIControlEvents event;
@property (nonatomic,retain) UITapGestureRecognizer *tap;
@property (nonatomic,retain) UIActivityIndicatorView *swit;
@end
@implementation BaseImageView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //活动指示器
        UIActivityIndicatorView *swit = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        swit.center = CGPointMake(frame.size.width/2, frame.size.height/2);

        swit.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [self addSubview:swit];
        self.swit = swit;
        
        [swit release];
        
        
        //图片的保存
        //这里是保存图片手势
        self.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longPress];
        longPress.minimumPressDuration = 0.5;
        

    }
    return self;
}

-(void)dealloc
{
    [_swit release];
    [_tap release];
    [super dealloc];
}
-(void)setImage:(UIImage *)image
{
    if (image != nil) {


//        NSLog(@"%f   %f",image.size.width,image.size.height);

    }
    
    [super setImage:image];
}
-(void)indicatorStopAnimating
{
    [self.swit stopAnimating];
}
-(void)indicatorStartAnimating{
    [self.swit startAnimating];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_event == UIControlEventTouchUpInside) {
        [_target performSelector:_action withObject:self];
    }
}
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    _target = target;
    _action = action;
    _event = controlEvents;
}





#pragma mark 图片的保存

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
        UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"成功保存到手机相册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        sleep(1);
        [alert show];
        [alert release];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
