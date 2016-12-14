//
//  PadButtonWithEditAndDetailPopoversForMonthCell.h
//  PadCalendar
//
//  Created by 葛岳 on 2016/11/22.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PadEvent.h"

@protocol PadButtonWithEditAndDetailPopoversForMonthCellProtocol <NSObject>

@required
- (void) saveEditedEvent:(PadEvent *)eventNew ofButton:(UIButton *)button;
- (void) deleteEventOfButton:(UIButton *)button;

@end

@interface PadButtonWithEditAndDetailPopoversForMonthCell : UIButton

@property (nonatomic, strong) id<PadButtonWithEditAndDetailPopoversForMonthCellProtocol> protocol;
@property (nonatomic, strong) PadEvent *event;

@end
