//
//  PadYearCalendarView.h
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/24.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PadYearCalendarViewProtocol <NSObject>
@required
- (void) showMonthCalendar;
@end

@interface PadYearCalendarView : UIView

@property (nonatomic, strong) id<PadYearCalendarViewProtocol> protocol;

- (void) invalidateLayout;

@end
