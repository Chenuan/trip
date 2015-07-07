//
//  travelListCell.h
//  Trip1
//
//  Created by ccyy on 15/6/22.
//  Copyright © 2015年 kevin. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "TravelList.h"

@interface TravelListCell : BaseTableViewCell
@property (retain,nonatomic) TravelList *tralist;

//+(travelListCell *)cellWithTableView:(UITableView *)tableView;
@end
