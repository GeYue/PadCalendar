//
//  PadEventContentPopoverController.h
//  PadCalendar
//
//  Created by 葛岳 on 2016/12/14.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PadEvent.h"

@protocol PadEventContentPopoverControllerProtocol <NSObject>

@required
- (void) showPopoverEditWithEvent:(PadEvent *)event;

@end

@interface PadEventContentPopoverController : UIViewController

@property(nonatomic, strong) id<PadEventContentPopoverControllerProtocol> protocol;

- (id) initWithEvent:(PadEvent *)eventInit;

@end
