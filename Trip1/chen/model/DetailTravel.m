//
//  DetailTravel.m
//  Trip1
//
//  Created by ccyy on 15/6/23.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "DetailTravel.h"
#import "UIImageView+AFNetworking.h"

@implementation DetailTravel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

//-(void)setAvatar_s:(NSString *)avatar_s
//{
//    if (_avatar_s != avatar_s) {
//        [_avatar_s release];
//        _avatar_s = [avatar_s retain];
//    }
//    NSLog(@"------");
//    NSURL *url = [NSURL URLWithString:avatar_s];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.headImageView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"1"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//        self.headImageView.image = image;
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//        NSLog(@"头像加载错误");
//    }];
//    
//}

-(void)setText:(NSString *)text
{
    if (text == nil) {
        NSLog(@"DetailTravel类里的text为空");
        _text = @"";
    }else{
        if (_text != text) {
            [_text release];
            _text = [text retain];
        }
    }
}

-(void)dealloc
{

    [_avatar_l release];
    [_city release];
    [_headImageView release];
    [_local_time release];
    [_photo release];
    [_name release];
    [_text release];
    [super dealloc];
}
@end
