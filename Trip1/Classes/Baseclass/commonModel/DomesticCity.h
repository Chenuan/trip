//
//  DomesticCity.h
//  MianBao
//
//  Created by lanou on 15/6/19.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Url.h"
@interface DomesticCity : NSObject
@property (nonatomic,retain) NSString *cover;
@property (nonatomic,retain) NSString *cover_s;
@property (nonatomic,retain) NSString *cover_route_map_cover;//以上为图片的三种尺寸

@property (nonatomic,retain) NSString *name_zh;//name

@property (nonatomic,retain) NSDictionary *location; //坐标
@property (nonatomic,retain) NSString *visited_count;
@property (nonatomic,retain) NSString *wish_to_go_count;

@property (nonatomic,retain) NSString *url; //拼接用url //url处理 scenic替换为  place

@property (nonatomic,retain) NSString *fullPath;//kurl+url的处理结果kUrl里面/index_places/8/ 替换为url

@end
