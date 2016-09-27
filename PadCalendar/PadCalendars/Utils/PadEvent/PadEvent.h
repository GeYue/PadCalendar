//
//  PadEvent.h
//  PadCalendar
//
//  Created by 葛岳 on 2016/9/27.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PadEvent : NSObject

@property (nonatomic, strong) NSString *stringEventName;
@property (nonatomic, strong) NSNumber *numEventID;
@property (nonatomic, strong) NSDate *dateDay;
@property (nonatomic, strong) NSDate *dateTimeBegin;
@property (nonatomic, strong) NSDate *dateTimeEnd;
@property (nonatomic, strong) NSString *stringEventContent;

@end
