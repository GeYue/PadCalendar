//
//  PadAddEventPopoverController
//  PadCalendar
//
//  Created by 葛岳 on 16/9/12.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PadEvent.h"

@protocol PadAddEventPopoverControllerProtocol <NSObject>

@required
- (void) addNewEvent:(PadEvent *)eventNew;

@end

@interface PadAddEventPopoverController : UIViewController

- (id) initPopover;

@property (nonatomic, strong) id<PadAddEventPopoverControllerProtocol> protocol;

@end
