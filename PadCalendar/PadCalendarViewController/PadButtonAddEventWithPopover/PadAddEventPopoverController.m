//
//  PadAddEventAlertController.m
//  PadCalendar
//
//  Created by 葛岳 on 16/9/12.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadAddEventPopoverController.h"
#import "UIColor+PadMoreColors.h"
#import "NSDate+PadDayCount.h"
#import "PadConstants.h"

#import "PadSearchBarWithAutoComplete.h"
#import "PadButtonWithDatePopover.h"
#import "PadButtonWithTimePopover.h"

#import "QuartzCore/QuartzCore.h"

@interface PadAddEventPopoverController ()

@property (nonatomic, strong) UIButton *buttonCancel;
@property (nonatomic, strong) UIButton *buttonDone;
@property (nonatomic, strong) UILabel *labelEventName;

@property (nonatomic, strong) PadButtonWithDatePopover *buttonDate;
@property (nonatomic, strong) PadButtonWithTimePopover *buttonTimeBegin;
@property (nonatomic, strong) PadButtonWithTimePopover *buttonTimeEnd;

@property (nonatomic, strong) UITextView *textEventView;

@property (nonatomic, strong) PadSearchBarWithAutoComplete *searchBarCustom;

@property (nonatomic, strong) PadEvent *currentDayEvent;

@end

@implementation PadAddEventPopoverController 

#pragma mark - Lifecycle

- (id) initPopover {
    
    NSDateComponents *component = [NSDate compoentsOfCurrentDate];
    self.currentDayEvent = [[PadEvent alloc] init];
    self.currentDayEvent.stringEventName = @"";
    self.currentDayEvent.dateDay = [NSDate date];
    self.currentDayEvent.dateTimeBegin = [NSDate dateWithHour:component.hour min:component.minute];
    self.currentDayEvent.dateTimeEnd = [NSDate dateWithHour:component.hour min:component.minute+15];
    self.currentDayEvent.stringEventContent = @"";

    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0., 0., 300., 1000.)];
    [self.view setBackgroundColor:[UIColor lightGrayCustom]];
    [self.view.layer setBorderColor:[UIColor lightGrayCustom].CGColor];
    [self.view.layer setBorderWidth:2.];
    
    [self addButtonCancelWithCustomView:self.view];
    [self addButtonDoneWithCustomView:self.view];
    [self addSearchBarWithCustomView:self.view];
    
    [self addSearchBarWithCustomView:self.view];
    [self addButtonDateWithCustomView:self.view];
    [self addButtonTimeBeginWithCustomView:self.view];
    [self addButtonTimeEndWithCustomView:self.view];
    
    [self addTextFieldEventWithCustomView:self.view];
    return self;
}


#pragma mark - Button Actions

- (IBAction)buttonCalcelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buttonDoneAction:(id)sender {
    PadEvent *newEvent = [[PadEvent alloc] init];
    newEvent.stringEventName = self.searchBarCustom.stringEventName;
    newEvent.numEventID = (self.searchBarCustom.numEventID) ? self.searchBarCustom.numEventID : [NSNumber numberWithInt:0];
    newEvent.dateDay = self.buttonDate.dateOfButton;
    newEvent.dateTimeBegin = self.buttonTimeBegin.dateOfButton;
    newEvent.dateTimeEnd = self.buttonTimeEnd.dateOfButton;
    newEvent.stringEventContent = self.textEventView.text;
    
    NSString *stringError = nil;
    if (![self isTimeBeginEarlier:newEvent.dateTimeBegin timeEnd:newEvent.dateTimeEnd]) {
        stringError = @"Start time must occur earlier than end time.";
    } else if (0 == newEvent.stringEventContent.length) {
        stringError = @"Please input the event content.";
    }
    
    if (stringError) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:stringError
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (_protocol && [_protocol respondsToSelector:@selector(addNewEvent:)]) {
        [_protocol addNewEvent:newEvent];
        [self buttonCalcelAction:nil];
    }
}

- (BOOL) isTimeBeginEarlier:(NSDate *)dateBegin timeEnd:(NSDate *)dateEnd {
    BOOL boolRet = YES;
    
    NSDateComponents *compDateBegin = [NSDate componentsOfDate:dateBegin];
    NSDateComponents *compDateEnd = [NSDate componentsOfDate:dateEnd];
    
    if ((compDateBegin.hour > compDateEnd.hour) || (compDateBegin.hour == compDateEnd.hour &&compDateBegin.minute >= compDateEnd.minute)) {
        boolRet = NO;
    }
    return boolRet;
}

#pragma mark - Add Subviews

- (void) addButtonCancelWithCustomView:(UIView *)customView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, customView.frame.size.width, BUTTON_HEIGHT+30)];
    [view setBackgroundColor:[UIColor lighterGrayCustom]];
    [customView addSubview:view];
    
    _buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self customLayoutOfButton:self.buttonCancel withTitle:@"Cancel"
                        action:@selector(buttonCalcelAction:) frame:CGRectMake(20, 0, 80, BUTTON_HEIGHT+30)];
    [view addSubview:_buttonCancel];
}

- (void) addButtonDoneWithCustomView:(UIView *)customView {
    _buttonDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [self customLayoutOfButton:self.buttonDone withTitle:@"Done"
                        action:@selector(buttonDoneAction:)
                         frame:CGRectMake(self.buttonCancel.superview.frame.size.width-80-10, self.buttonCancel.frame.origin.y, 80, self.buttonCancel.frame.size.height)];
    [self.buttonCancel.superview addSubview:self.buttonDone];
}

- (void) addSearchBarWithCustomView:(UIView *)customView {
    _searchBarCustom = [[PadSearchBarWithAutoComplete alloc] initWithDateAndFrame:self.currentDayEvent.dateDay Frame:CGRectMake(0, _buttonCancel.superview.frame.origin.y+_buttonCancel.superview.frame.size.height+BUTTON_HEIGHT, customView.frame.size.width, BUTTON_HEIGHT)];
    [customView addSubview:_searchBarCustom];
}

- (void) addButtonDateWithCustomView:(UIView *)customView {
    _buttonDate = [[PadButtonWithDatePopover alloc] initWithFrame:CGRectMake(0, _searchBarCustom.frame.origin.y+_searchBarCustom.frame.size.height+2, customView.frame.size.width, BUTTON_HEIGHT) date:_currentDayEvent.dateDay];
    [customView addSubview:_buttonDate];
}

- (void) addButtonTimeBeginWithCustomView:(UIView *)customView {
    _buttonTimeBegin = [[PadButtonWithTimePopover alloc] initWithFrame:CGRectMake(0, _buttonDate.frame.origin.y+_buttonDate.frame.size.height+BUTTON_HEIGHT, customView.frame.size.width, BUTTON_HEIGHT) date:_currentDayEvent.dateTimeBegin];
    [customView addSubview:_buttonTimeBegin];
}

- (void) addButtonTimeEndWithCustomView:(UIView *)customView {
    _buttonTimeEnd = [[PadButtonWithTimePopover alloc] initWithFrame:CGRectMake(0, _buttonTimeBegin.frame.origin.y+_buttonTimeBegin.frame.size.height+2, customView.frame.size.width, BUTTON_HEIGHT) date:_currentDayEvent.dateTimeEnd];
    [customView addSubview:_buttonTimeEnd];
}

- (void) addTextFieldEventWithCustomView:(UIView *)customView {
    _textEventView = [[UITextView alloc] initWithFrame:CGRectMake(0, _buttonTimeEnd.frame.origin.y+_buttonTimeEnd.frame.size.height+BUTTON_HEIGHT, customView.frame.size.width, BUTTON_HEIGHT*5)];
    
    _textEventView.backgroundColor = [UIColor whiteColor];
    _textEventView.font = [UIFont fontWithName:@"Arial" size:20.0f];
    _textEventView.text = @"";
    _textEventView.scrollEnabled = YES;
    
    [_textEventView.layer setCornerRadius:10];
    
    [customView addSubview:_textEventView];
}

#pragma mark - Button Layout

- (void)customLayoutOfButton:(UIButton *)button withTitle:(NSString *)title action:(SEL)action frame:(CGRect)frame {
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:button.titleLabel.font.pointSize]];
    [button setFrame:frame];
    [button setContentMode:UIViewContentModeScaleAspectFit];
}

#pragma mark - UIGestureRecognizer Delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    //CGPoint point = [gestureRecognizer locationInView:self];
    
    return NO;
}

@end
