//
//  LineCell.m
//  Trip1
//
//  Created by ccyy on 15/7/1.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "LineCell.h"

@implementation LineCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
 -(void)setDayline:(DayLine *)dayline
{
    if (_dayline != dayline) {
        [_dayline release];
        _dayline = [dayline retain];
    }
    NSLog(@"dayline.date = %@,dayline.days = %ld,dayline.name = %@",dayline.date,dayline.days,dayline.name);
    self.datelabel.text = [NSString stringWithFormat:@"%@,第%ld天",dayline.date,dayline.days];
    self.addressLabel.text = dayline.name;
    NSLog(@"self.datelabel.text = %@",self.datelabel.text);
    NSLog(@"self.addressLabel.text = %@",self.addressLabel.text);
    
    
    
    
}







- (void)dealloc {
    [_datelabel release];
    [_addressLabel release];
    [super dealloc];
}
@end
