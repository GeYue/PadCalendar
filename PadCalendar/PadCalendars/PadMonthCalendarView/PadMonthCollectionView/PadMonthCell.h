//
//  PadMonthCell.h
//  PadCalendar
//
//  Created by 葛岳 on 2016/11/9.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PadEvent.h"

@protocol PadMonthCellProtocol <NSObject>

@required
- (void) saveEditedEvent:(PadEvent *)eventNew ofCell:(UICollectionViewCell *)cell atIndex:(NSInteger)index;
- (void) deleteEventOfCell:(UICollectionViewCell *)cell atIndex:(NSInteger)index;

@end

@interface PadMonthCell : UICollectionViewCell
@property (nonatomic, strong) id<PadMonthCellProtocol> protocol;
@property (strong, nonatomic) UILabel *labelDay;

- (void) initLayout;
- (void) markAsWeekend;
- (void) markAsCurrentDay;

@end
