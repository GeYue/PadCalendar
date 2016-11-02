//
//  PadMonthCellForYearCell.h
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/31.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PadMonthCellForYearCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *labelDay;

- (void) initLayout;

- (void) markAsCurrentDay;

@end
