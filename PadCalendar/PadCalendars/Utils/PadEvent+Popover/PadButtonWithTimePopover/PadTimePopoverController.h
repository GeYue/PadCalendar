//
//  PadTimePopoverController.h
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/7.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PadTimePopoverControllerProtocol <NSObject>
@required
- (void) valueChanged:(NSDate *)newDate;

@end

@interface PadTimePopoverController : UIViewController
@property (nonatomic, strong) id<PadTimePopoverControllerProtocol> protocol;

- (id) initWithDate:(NSDate *)date;

@end
