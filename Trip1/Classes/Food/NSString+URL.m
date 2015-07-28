//
//  NSString+URL.m
//  UIText
//
//  Created by lanou on 15/6/12.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "NSString+URL.h"
@implementation NSString (URL)
- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8);
    return encodedString;
}

@end
