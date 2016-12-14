//
//  PadMonthCell.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/11/9.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadMonthCell.h"
#import "PadButtonWithEditAndDetailPopoversForMonthCell.h"
#import "PadCalendars.h"


@interface PadMonthCell() <PadButtonWithEditAndDetailPopoversForMonthCellProtocol>
@property (nonatomic, strong) NSMutableArray *arrayButtons;
@end

@implementation PadMonthCell

#pragma mark - Lifecycle

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //initialize code
    }
    return self;
}

- (void) initLayout {
    if (!_imageViewCircle){
        _imageViewCircle = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-32.-3., 3., 32., 32.)];
        [_imageViewCircle setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin)];
        [self addSubview:_imageViewCircle];
        
        _labelDay = [[UILabel alloc] initWithFrame:CGRectMake((_imageViewCircle.frame.size.width-20.)/2, (_imageViewCircle.frame.size.height-20.)/2, 22., 22.)];
        [_labelDay setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin)];
        [_labelDay setTextAlignment:NSTextAlignmentCenter];
        [_imageViewCircle addSubview:_labelDay];
    }
    
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.labelDay setText:@""];
    [self.labelDay setTextColor:[UIColor blackColor]];
    [self.imageViewCircle setImage:nil];
    
    for (UIButton *button in _arrayButtons){
        [button removeFromSuperview];
    }
}

#pragma mark - Custom Layout

- (void) markAsWeekend {
    [self setBackgroundColor:[UIColor lighterGrayCustom]];
    [self.labelDay setTextColor:[UIColor grayColor]];
}

- (void) markAsCurrentDay {
    [self.labelDay setTextColor:[UIColor whiteColor]];
    [self.imageViewCircle setImage:[UIImage imageNamed:@"redCircle"]];
}

#pragma mark - Showing Events

- (void) setArrayEvents:(NSMutableArray *)array {
    _arrayEvents = array;
    _arrayButtons = [NSMutableArray new];
    
    if (_arrayEvents.count > 0) {
        int nMaxNumOfButton = 4;
        CGFloat yFirstButton = _imageViewCircle.frame.origin.y + _imageViewCircle.frame.size.height;
        CGFloat height = (self.frame.size.height - yFirstButton)/nMaxNumOfButton;
        
        int buttonOfNumber = 0;
        for (int i=0; i<_arrayEvents.count; i++) {
            buttonOfNumber++;
            PadButtonWithEditAndDetailPopoversForMonthCell *button = [[PadButtonWithEditAndDetailPopoversForMonthCell alloc] initWithFrame:CGRectMake(0, yFirstButton+(buttonOfNumber-1)*height, self.frame.size.width, height)];
            [button setAutoresizingMask:AR_TOP_BOTTOM | UIViewAutoresizingFlexibleWidth];
            [self addSubview:button];
            [_arrayButtons addObject:button];
            
            if ((buttonOfNumber == nMaxNumOfButton) || (_arrayEvents.count - nMaxNumOfButton) > 0) {
                [button setTitle:[NSString stringWithFormat:@"%lu more...", (long)(_arrayEvents.count - nMaxNumOfButton)] forState:UIControlStateNormal];
                break;
            } else {
                PadEvent *event = [_arrayEvents objectAtIndex:i];
                [button setTitle:event.stringEventName forState:UIControlStateNormal];
                [button setEvent:event];
                [button setProtocol:self];
            }
        }
    }
}

#pragma mark - PadButtonWithEditAndDetailPopoversForMonthCell Protocol

- (void) saveEditedEvent:(PadEvent *)eventNew ofButton:(UIButton *)button {
    long i = [_arrayEvents indexOfObject:button];
    if (_protocol && [_protocol respondsToSelector:@selector(saveEditedEvent:ofCell:atIndex:)]){
        [_protocol saveEditedEvent:eventNew ofCell:self atIndex:i];
    }
}

- (void) deleteEventOfButton:(UIButton *)button {
    long i = [_arrayEvents indexOfObject:button];
    if (_protocol && [_protocol respondsToSelector:@selector(deleteEventOfButton:)]) {
        [_protocol deleteEventOfCell:self atIndex:i];
    }
}

@end
