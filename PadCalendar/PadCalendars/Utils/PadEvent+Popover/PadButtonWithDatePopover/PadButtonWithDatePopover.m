//
//  PadButtonWithDatePopover.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/9/29.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadButtonWithDatePopover.h"
#import "PadDatePopoverController.h"

#import "PadCalendars.h"

@interface PadButtonWithDatePopover ()
@property (nonatomic, strong) PadDatePopoverController *popoverDateController;
@end

@implementation PadButtonWithDatePopover

#pragma mark - Lifecycle

- (id) initWithFrame:(CGRect)frame date:(NSDate *)date {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

        NSDateComponents *compDate = date.componentsOfDate;
        self.dateOfButton = [NSDate dateWithYear:compDate.year month:compDate.month day:compDate.day];
        [self setTitle:[NSDate stringDayOfDate:date] forState:UIControlStateNormal];
    }
    
    return self;
}

#pragma mark - Button Action

- (IBAction)buttonAction:(id)sender {
    self.popoverDateController = [[PadDatePopoverController alloc] initWithDate:self.dateOfButton];
    UIDatePicker *datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];

    self.popoverDateController.preferredContentSize = datePickerView.frame.size;
    self.popoverDateController.modalPresentationStyle = UIModalPresentationPopover;
    //[self.popoverDateController setProtocol:self];
    
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
       if ([responder isKindOfClass: [UIViewController class]])
            break;
    UIViewController *respondController = (UIViewController *)responder;
    [respondController presentViewController:self.popoverDateController
                                    animated:YES completion:nil];
    UIPopoverPresentationController *presentController = [self.popoverDateController popoverPresentationController];
    presentController.permittedArrowDirections = UIPopoverArrowDirectionRight;
    
    UIButton *button = (UIButton *)sender;
    presentController.sourceView = sender;
    presentController.sourceRect = CGRectMake(0, 0, button.frame.size.width, button.frame.size.height);
}

@end
