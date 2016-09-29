//
//  PadButtonWithTimePopover.h
//  PadCalendar
//
//  Created by 葛岳 on 2016/9/29.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PadButtonWithTimePopover : UIButton

@property (nonatomic, strong) NSDate *dateOfButton;

- (id) initWithFrame:(CGRect)frame date:(NSDate *)date;

@end
