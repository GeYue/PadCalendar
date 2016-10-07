//
//  PadTimePopoverController.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/7.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadTimePopoverController.h"

@interface PadTimePopoverController ()
@property (nonatomic, strong) UIDatePicker *timePickerView;
@end

@implementation PadTimePopoverController

-  (id) initWithDate:(NSDate *)date {
    _timePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, _timePickerView.frame.size.width, _timePickerView.frame.size.height)];
    [_timePickerView setDatePickerMode:UIDatePickerModeTime];
    
    [_timePickerView setDate:date animated:YES];
    [_timePickerView addTarget:self action:@selector(valuePickerChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_timePickerView];
    return self;
}

- (IBAction)valuePickerChanged:(id)sender {
    if (_protocol && [_protocol respondsToSelector:@selector(valueChanged:)]) {
        [_protocol valueChanged:_timePickerView.date];
    }
}

@end
