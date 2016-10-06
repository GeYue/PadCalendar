//
//  PadDatePopoverController.h
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/6.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PadDatePopoverControllerProtocol <NSObject>
@required
- (void) valueChanged:(NSDate *)newDate;

@end

@interface PadDatePopoverController : UIViewController

@property (nonatomic, strong) id<PadDatePopoverControllerProtocol> protocol;

- (id) initWithDate:(NSDate *)date;

@end
