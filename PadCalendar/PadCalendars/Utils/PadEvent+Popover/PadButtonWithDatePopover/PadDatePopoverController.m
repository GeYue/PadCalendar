//
//  PadDatePopoverController.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/6.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadDatePopoverController.h"

@interface PadDatePopoverController () <UIPickerViewDelegate>
@property (nonatomic, strong) UIViewController *popContent;
@property (nonatomic, strong) UIDatePicker *datePickerView;
@end

@implementation PadDatePopoverController

- (id) initWithDate:(NSDate *)date {
    self.datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height)];
    [self.datePickerView setDatePickerMode:UIDatePickerModeDate];
    [self.datePickerView setDate:date];
    [self.datePickerView addTarget:self action:@selector(valueOfPickerChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.popContent = [[UIViewController alloc] init];
    self.popContent.view = self.datePickerView;
    self.popContent.preferredContentSize = self.datePickerView.frame.size;
    
    [self.view addSubview:self.datePickerView];
    
    return self;
}

- (IBAction)valueOfPickerChanged:(id)sender {
    
}

@end
