//
//  PadEditEventView.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/12/15.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadEditEventView.h"

#import "PadCalendars.h"
#import "PadSearchBarWithAutoComplete.h"
#import "PadButtonWithTimePopover.h"
#import "PadButtonWithDatePopover.h"

@interface PadEditEventView () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) PadEvent *event;
@property (nonatomic, strong) UIButton *buttonCalcel;
@property (nonatomic, strong) UIButton *buttonDone;
@property (nonatomic, strong) UIButton *buttonDelete;
@property (nonatomic, strong) UILabel *labelEventName;
@property (nonatomic, strong) PadSearchBarWithAutoComplete *searchBarCustom;
@property (nonatomic, strong) PadButtonWithDatePopover *buttonDate;
@property (nonatomic, strong) PadButtonWithTimePopover *buttonTimeBegin;
@property (nonatomic, strong) PadButtonWithTimePopover *buttonTimeEnd;
@property (nonatomic, strong) UITextView *textEventView;
@end

@implementation PadEditEventView

#pragma mark - Lifecycle

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame event:(PadEvent *)event {
    self = [super initWithFrame:frame];
    if (self) {
        _event = event;
        
        [self setBackgroundColor:[UIColor lightGrayCustom]];
        [self.layer setBorderColor:[UIColor lightGrayCustom].CGColor];
        [self.layer setBorderWidth:2.0];
        
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [gesture setDelegate:self];
        [self addGestureRecognizer:gesture];
        
        [self addButtonCalcel];
        [self addButtonDone];
        [self addSearchBar];
        [self addButtonDate];
        [self addButtonTimeBegin];
        [self addButtonTimeEnd];
        [self addTextView];
        [self addButtonDelete];
    }
    return self;
}

#pragma mark - Button Actions

- (IBAction)buttonCancelAction:(id)sender {
    if (_protocol && [_protocol respondsToSelector:@selector(removeThisView:)]) {
        [_protocol removeThisView:self];
    }
}

- (IBAction)buttonDoneAction:(id)sender {
    PadEvent *eventNew = [PadEvent new];
    eventNew.stringEventName = _searchBarCustom.stringEventName;
    eventNew.numEventID = _searchBarCustom.numEventID ? _searchBarCustom.numEventID : [NSNumber numberWithInt:0];
    eventNew.dateDay = _buttonDate.dateOfButton;
    eventNew.dateTimeBegin = _buttonTimeBegin.dateOfButton;
    eventNew.dateTimeEnd = _buttonTimeEnd.dateOfButton;
    eventNew.stringEventContent = _textEventView.text;
    
    NSString *stringError = nil;
    if (![self isTimeBeginEarlier:eventNew.dateTimeBegin timeEnd:eventNew.dateTimeEnd]) {
        stringError = @"Start time must occur earlier than end time.";
    } else if (0 == eventNew.stringEventContent.length) {
        stringError = @"Please input the event content.";
    }
    
    if (stringError) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:stringError preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:defaultAction];
        
    } else if (_protocol && [_protocol respondsToSelector:@selector(addNewEvent:)]) {
        [_protocol saveEvent:eventNew];
        [self buttonCancelAction:nil];
    }
}

- (IBAction)buttonDeleteAction:(id)sender {
    if (_protocol && [_protocol respondsToSelector:@selector(deleteEvent:)]) {
        [_protocol deleteEvent:_event];
    }
    [self buttonCancelAction:nil];
}

- (BOOL) isTimeBeginEarlier:(NSDate *)dateBegin timeEnd:(NSDate *)dateEnd {
    BOOL bootRet = YES;
    
    NSDateComponents *compDateBegin = [NSDate componentsOfDate:dateBegin];
    NSDateComponents *compDateEnd = [NSDate componentsOfDate:dateEnd];
    
    if ((compDateBegin.hour > compDateEnd.hour) || (compDateBegin.hour == compDateEnd.hour && compDateBegin.minute >= compDateEnd.minute)) {
        bootRet = NO;
    }
    return bootRet;
}

#pragma mark - Tap Gesture

- (void) handleTap:(UITapGestureRecognizer *)recognizer {
    [_searchBarCustom closeKeyboardAndTableView];
}

#pragma mark - Add Subviews

- (void) addButtonCalcel {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, BUTTON_HEIGHT+30)];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [view setBackgroundColor:[UIColor lighterGrayCustom]];
    
    _buttonCalcel = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonCalcel setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin];
    [self customLayoutOfButton:_buttonCalcel withTitle:@"Cancel" action:@selector(buttonCancelAction:)
                         frame:CGRectMake(20, 0, 80, BUTTON_HEIGHT+30)];
    [view addSubview:_buttonCalcel];
    
    [self addSubview:view];
}

- (void) addButtonDone {
    _buttonDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonDone setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self customLayoutOfButton:_buttonDone withTitle:@"Done" action:@selector(buttonDoneAction:)
                         frame:CGRectMake(_buttonCalcel.superview.frame.size.width-80-10, _buttonCalcel.frame.origin.y, 80, _buttonCalcel.frame.size.height)];
    [_buttonCalcel.superview addSubview:_buttonDone];
}

- (void) addSearchBar {
    _searchBarCustom = [[PadSearchBarWithAutoComplete alloc] initWithFrame:CGRectMake(0, _buttonCalcel.superview.frame.origin.y+_buttonCalcel.superview.frame.size.height+BUTTON_HEIGHT, self.frame.size.width, BUTTON_HEIGHT)];
    [_searchBarCustom setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_searchBarCustom setNumEventID:_event.numEventID];
    [self addSubview:_searchBarCustom];
}

- (void) addButtonDate {
    _buttonDate = [[PadButtonWithDatePopover alloc] initWithFrame:CGRectMake(0, _searchBarCustom.frame.origin.y+_searchBarCustom.frame.size.height+2, self.frame.size.width, BUTTON_HEIGHT) date:_event.dateDay];
    [_buttonDate setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:_buttonDate];
}

- (void) addButtonTimeBegin {
    _buttonTimeBegin = [[PadButtonWithTimePopover alloc] initWithFrame:CGRectMake(0, _buttonDate.frame.origin.y+_buttonDate.frame.size.height+BUTTON_HEIGHT, self.frame.size.width, BUTTON_HEIGHT) date:_event.dateTimeBegin];
    [_buttonTimeBegin setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:_buttonTimeBegin];
}

- (void) addButtonTimeEnd {
    _buttonTimeEnd = [[PadButtonWithTimePopover alloc] initWithFrame:CGRectMake(0, _buttonTimeBegin.frame.origin.y+_buttonTimeBegin.frame.size.height+2, self.frame.size.width, BUTTON_HEIGHT) date:_event.dateTimeEnd];
    [_buttonTimeEnd setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:_buttonTimeEnd];
}

- (void) addButtonDelete {
    _buttonDelete = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonDelete setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    [self customLayoutOfButton:_buttonDelete withTitle:@"Delete Event" action:@selector(buttonDeleteAction:) frame:CGRectMake(0, self.frame.size.height-2*BUTTON_HEIGHT, self.frame.size.width, 2*BUTTON_HEIGHT)];
    [_buttonDelete setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_buttonDelete];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _buttonDelete.frame.origin.y-BUTTON_HEIGHT, self.frame.size.width, BUTTON_HEIGHT)];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    [self addSubview:view];
}

- (void) addTextView {
    _textEventView = [[UITextView alloc] initWithFrame:CGRectMake(0, _buttonTimeEnd.frame.origin.y+_buttonTimeEnd.frame.size.height+BUTTON_HEIGHT, self.frame.size.width, BUTTON_HEIGHT*5)];
    [_textEventView setBackgroundColor:[UIColor whiteColor]];
    [_textEventView setFont:[UIFont fontWithName:@"Arial" size:20.0f]];
    _textEventView.text = @"";
    [_textEventView setScrollEnabled:YES];
    
    [_textEventView.layer setCornerRadius:10];
    [self addSubview:_textEventView];
}

#pragma mark - Button Layout

- (void) customLayoutOfButton:(UIButton *)button withTitle:(NSString *)title action:(SEL)action frame:(CGRect)frame {
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:button.titleLabel.font.pointSize]];
    [button setFrame:frame];
    [button setContentMode:UIViewContentModeScaleAspectFit];
}

#pragma mark - UIGestureRecognizer Delegate

- (BOOL) gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    BOOL bRet = NO;
    //CGPoint point = [gestureRecognizer locationInView:self];
    
    //bRet = !(_searchBarCustom.arrayOfTableView.count != 0 && CGRectContainsPoint(_searchBarCustom.tableViewCustom.frame, point)) &&
    //_searchBarCustom.tableViewCustom.superview;
    return bRet;
}

@end
