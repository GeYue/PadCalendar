//
//  PadEvent.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/9/27.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadEvent.h"

@implementation PadEvent

- (id) initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.stringEventName = [coder decodeObjectForKey:@"eventName"];
        self.numEventID = [coder decodeObjectForKey:@"eventId"];
        self.dateDay = [coder decodeObjectForKey:@"dateDay"];
        self.dateTimeBegin = [coder decodeObjectForKey:@"dateTimeBegin"];
        self.dateTimeEnd = [coder decodeObjectForKey:@"dateTimeEnd"];
        self.stringEventContent = [coder decodeObjectForKey:@"eventContent"];
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.stringEventName forKey:@"eventName"];
    [coder encodeObject:self.numEventID forKey:@"eventId"];
    [coder encodeObject:self.dateDay forKey:@"dateDay"];
    [coder encodeObject:self.dateTimeBegin forKey:@"dateTimeBegin"];
    [coder encodeObject:self.dateTimeEnd forKey:@"dateTimeEnd"];
    [coder encodeObject:self.stringEventContent forKey:@"eventContent"];
}

@end
