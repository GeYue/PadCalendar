//
//  PadHeaderMonthForYearCell.h
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/31.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PadHeaderMonthForYearCell : UICollectionReusableView

@property (nonatomic, strong) NSDate *date;

- (void) addWeekLabelWithSizeOfCells:(CGSize)sizeOfCells;

@end
