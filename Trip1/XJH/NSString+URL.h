//
//  NSString+URL.h
//  UIText
//
//  Created by lanou on 15/6/12.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)
- (NSString *)URLEncodedString;
+(NSString *)URLforCategory:(NSString *)category;
@end
