//
//  PadDateManager.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/25.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadDateManager.h"

@implementation PadDateManager

- (id) init {
    if (self = [super init]) {
        _currentDate = [NSDate new];
    }
    return self;
}

- (void) dealloc {
    
}

+ (id) sharedManager {
    static PadDateManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

- (void) setCurrentDate:(NSDate *)currentDate {
    _currentDate = currentDate;
    [[NSNotificationCenter defaultCenter] postNotificationName:DATE_MANAGER_DATE_CHANGED object:currentDate];
}

@end
