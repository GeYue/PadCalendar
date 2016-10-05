//
//  PadAddEventPopoverButton.h
//  PadCalendar
//
//  Created by 葛岳 on 16/9/10.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PadEvent.h"

@protocol PadButtonAddEventWithPopoverProtocol <NSObject>

@required
- (void) addNewEvent:(PadEvent *)eventNew;

@end

@interface PadAddEventPopoverButton : UIButton

@property (nonatomic, strong) id<PadButtonAddEventWithPopoverProtocol> protocol;

@end
