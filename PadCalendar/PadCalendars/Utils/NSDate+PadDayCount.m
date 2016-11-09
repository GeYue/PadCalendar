//
//  NSDate+PadDayCount.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/5.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "NSDate+PadDayCount.h"
#import "PadConstants.h"

@implementation NSDate (PadDayCount)

#pragma mark - Class Methods

+ (NSDateComponents *) componentsOfDate:(NSDate *)date {
    return [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitHour  | NSCalendarUnitMinute fromDate:date];
}

+ (NSDateComponents *) componentsOfCurrentDate {
    return [NSDate componentsOfDate:[NSDate date]];
}

+ (NSDateComponents *) componentsWithHour:(NSInteger)hour min:(NSInteger)min {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:hour];
    [components setMinute:min];
    
    return components;
}

+ (NSDate *) dateWithHour:(NSInteger)hour min:(NSInteger)min {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [NSDate componentsWithHour:hour min:min];
    
    return [calendar dateFromComponents:components];
}

+ (NSDate *) dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [NSDate componentsWithYear:year month:month day:day];
    
    return [calendar dateFromComponents:components];
}

+ (NSDateComponents *) componentsWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    
    return components;
}

+ (NSString *) stringDayOfDate:(NSDate *)date {
    NSDateComponents *comp = [NSDate componentsOfDate:date];
    
    return [NSString stringWithFormat:@"%@, %@ %li, %li", [dictWeekNumberName objectForKey:[NSNumber numberWithLong:comp.weekday]], [arrayMonthNameAbrev objectAtIndex:comp.month-1], (long)comp.day, (long)comp.year];
}

+ (NSString *) stringTimeOfDate:(NSDate *)date {
    NSDateFormatter *dateFormater = [NSDateFormatter new];
    [dateFormater setDateFormat:@"HH:mm"];
    
    return [dateFormater stringFromDate:date];
}

+ (BOOL)isTheSameDateTheCompA:(NSDateComponents *)compA compB:(NSDateComponents *)compB {
    
    return ([compA day]==[compB day] && [compA month]==[compB month ]&& [compA year]==[compB year]);
}

#pragma mark - Object Methods

- (NSDateComponents *) componentsOfDate {
    return [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:self];
}

- (NSInteger) numberOfDaysInMonthCount {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange dayRange = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    
    return dayRange.length;
}

- (NSInteger) numberOfWeeksInMonthCount {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange weekRange = [calendar rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:self];
    
    return weekRange.length;
}

@end
