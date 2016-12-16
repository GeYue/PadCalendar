//
//  PadEditEventViewController.h
//  PadCalendar
//
//  Created by 葛岳 on 2016/12/16.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PadEvent.h"

@protocol PadEditEventViewControllerProtocol <NSObject>

@required
- (void) saveEditedEvent:(PadEvent *)eventNew;
- (void) deleteEvent;

@end


@interface PadEditEventViewController : UIViewController

@property (nonatomic, strong) id<PadEditEventViewControllerProtocol> protocol;

- (id) initWithEvent:(PadEvent *)eventInit;

@end
