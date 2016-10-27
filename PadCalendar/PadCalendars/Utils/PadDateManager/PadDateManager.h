//
//  PadDateManager.h
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/25.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <Foundation/Foundation.h>


#define DATE_MANAGER_DATE_CHANGED @"br.com.PadCalendar.DateManager.DateChanged"
#define DATE_MANAGER_DATE_CHANGED_KEY @"br.com.PadCalendar.DateManager.DateChanged.Key"

@interface PadDateManager : NSObject

@property (nonatomic, strong) NSDate *currentDate;

+ (id) sharedManager;

@end
