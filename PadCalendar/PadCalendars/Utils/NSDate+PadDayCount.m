//
//  NSDate+PadDayCount.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/5.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "NSDate+PadDayCount.h"

@implementation NSDate (PadDayCount)

+ (NSDateComponents *) componentsOfDate:(NSDate *)date {
    return [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitHour  | NSCalendarUnitMinute fromDate:date];
}

@end
