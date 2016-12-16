//
//  PadEditEventView.h
//  PadCalendar
//
//  Created by 葛岳 on 2016/12/15.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PadEvent.h"

@protocol PadEditEventViewProtocol <NSObject>

@required
- (void) saveEvent:(PadEvent *)event;
- (void) deleteEvent:(PadEvent *)event;
- (void) removeThisView:(UIView *)view;

@end

@interface PadEditEventView : UIView

@property (nonatomic, strong) id<PadEditEventViewProtocol> protocol;

- (id) initWithFrame:(CGRect)frame event:(PadEvent *)event;

@end
