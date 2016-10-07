//
//  PadButtonWithTimePopover.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/9/29.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadButtonWithTimePopover.h"
#import "PadTimePopoverController.h"

#import "PadCalendars.h"

@interface PadButtonWithTimePopover () <PadTimePopoverControllerProtocol>
@property (nonatomic, strong) PadTimePopoverController *popoverTimeController;
@end

@implementation PadButtonWithTimePopover

#pragma mark - Lifecycle

- (id) initWithFrame:(CGRect)frame date:(NSDate *)date {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        NSDateComponents *compDate = date.componentsOfDate;
        self.dateOfButton = [NSDate dateWithYear:compDate.year month:compDate.month day:compDate.day];
        [self setTitle:[NSDate stringTimeOfDate:date] forState:UIControlStateNormal];
    }
    
    return self;
}

#pragma mark - Button Action

- (IBAction)buttonAction:(id)sender {
    _popoverTimeController = [[PadTimePopoverController alloc] initWithDate:_dateOfButton];
    
    UIDatePicker *datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    _popoverTimeController.preferredContentSize = datePickerView.frame.size;
    
    _popoverTimeController.modalPresentationStyle = UIModalPresentationPopover;
    [_popoverTimeController setProtocol:self];
    
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            break;
    UIViewController *respondController = (UIViewController *)responder;
    [respondController presentViewController:_popoverTimeController animated:YES completion:nil];
    
    UIPopoverPresentationController *presentController = [_popoverTimeController popoverPresentationController];
    presentController.permittedArrowDirections = UIPopoverArrowDirectionRight;
    
    UIButton *button = (UIButton *)sender;
    presentController.sourceView = sender;
    presentController.sourceRect = CGRectMake(0, 0, button.frame.size.width, button.frame.size.height);
}

#pragma mark - PadTimePopoverController Protocal

- (void) valueChanged:(NSDate *)newDate {
    _dateOfButton = newDate;
    [self setTitle:[NSDate stringTimeOfDate:_dateOfButton] forState:UIControlStateNormal];
}

@end
