//
//  BaseView.m
//  Trip1
//
//  Created by lanou on 15/6/22.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "BaseView.h"


@interface BaseView()
@property (nonatomic,assign) id target;
@property (nonatomic,assign) SEL action;
@property (nonatomic,assign) UIControlEvents event;
@property (nonatomic,retain) UITapGestureRecognizer *tap;
@end
@implementation BaseView

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
////        self.tap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)] autorelease];
//    }
//    return self;
//}
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
