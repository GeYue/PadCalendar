//
//  PadMonthCalendarView.h
//  PadCalendar
//
//  Created by 葛岳 on 2016/11/9.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PadMonthCalendarViewProtocol <NSObject>

@required
- (void) setNewDictionary:(NSDictionary *)dict;

@end

@interface PadMonthCalendarView : UIView

@property (nonatomic, strong) NSMutableDictionary *dictEvents;
@property (nonatomic, strong) id<PadMonthCalendarViewProtocol> protocol;

- (void) invalidateLayout;

@end
