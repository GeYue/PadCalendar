//
//  PadMonthCollectionViewForYearCell.h
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/31.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PadMonthCollectionViewForYearCellProtocol <NSObject>

@required
- (void) showMonthCalendar;

@end

@interface PadMonthCollectionViewForYearCell : UICollectionView

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) id<PadMonthCollectionViewForYearCellProtocol> protocol;

@end
