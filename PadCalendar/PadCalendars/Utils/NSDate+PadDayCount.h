//
//  NSDate+PadDayCount.h
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/5.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (PadDayCount)

+ (NSDateComponents *) componentsOfDate:(NSDate *)date;

+ (NSDateComponents *) compoentsOfCurrentDate;

+ (NSDate *) dateWithHour:(NSInteger)hour min:(NSInteger)min;

+ (NSDateComponents *) componentsWithHour:(NSInteger)hour min:(NSInteger)min;

+ (NSDate *) dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

+ (NSString *) stringDayOfDate:(NSDate *)date;

+ (NSString *) stringTimeOfDate:(NSDate *)date;

- (NSDateComponents *) componentsOfDate;

@end
