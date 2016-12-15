//
//  PadEventContentView.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/12/14.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadEventContentView.h"

#import "PadCalendars.h"

@interface PadEventContentView ()
@property (nonatomic, strong) PadEvent *event;
@property (nonatomic, strong) UILabel *labelCustomName;
@property (nonatomic, strong) UILabel *labelDate;
@property (nonatomic, strong) UILabel *labelTime;
@end

@implementation PadEventContentView

#pragma mark - Lifecycle

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // initialize code.
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame event:(PadEvent *)event {
    self = [super initWithFrame:frame];
    if (self) {
        _event = event;
        
        [self.layer setBorderColor:[UIColor lightGrayCustom].CGColor];
        [self.layer setBorderWidth:2.];
        
        [self addButtonEditPopoverWithViewSize:frame.size];
        [self addLabelCustomnameWithViewSize:frame.size];
        [self addLabelDateWithViewSize:frame.size];
        [self addLabelTimeWithViewSize:frame.size];
    }
    return self;
}

#pragma mark - Button IBAction

- (IBAction)buttonEditPopoverAction:(id)sender {
    if (_protocol && [_protocol respondsToSelector:@selector(showEditViewWithEvent:)]) {
        [_protocol showEditViewWithEvent:_event];
    }
}

#pragma mark - Add Subviews

- (void) addButtonEditPopoverWithViewSize:(CGSize)sizeView {
    CGFloat width = 50;
    CGFloat height = BUTTON_HEIGHT;
    CGFloat gap = 30;
    
    _buttonEditPopover = [[UIButton alloc] initWithFrame:CGRectMake(sizeView.width-width-gap, 22, width, height)];
    [_buttonEditPopover setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_buttonEditPopover setTitle:@"Edit" forState:UIControlStateNormal];
    [_buttonEditPopover.titleLabel setFont:[UIFont boldSystemFontOfSize:_buttonEditPopover.titleLabel.font.pointSize]];
    [_buttonEditPopover addTarget:self action:@selector(buttonEditPopoverAction:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonEditPopover setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
    
    [self addSubview:_buttonEditPopover];
}

- (void) addLabelCustomnameWithViewSize:(CGSize)sizeView {
    CGFloat gap = 30;
    
    _labelCustomName = [[UILabel alloc] initWithFrame:CGRectMake(gap, _buttonEditPopover.frame.origin.y, sizeView.width-3*gap-_buttonEditPopover.frame.size.width, _buttonEditPopover.frame.size.height)];
    [_labelCustomName setText:_event.stringEventName];
    [_labelCustomName setFont:[UIFont boldSystemFontOfSize:_labelCustomName.font.pointSize]];
    
    [self addSubview:_labelCustomName];
}

- (void) addLabelDateWithViewSize:(CGSize)sizeView {
    CGFloat gap = 30;
    _labelDate = [[UILabel alloc] initWithFrame:CGRectMake(gap, _labelCustomName.frame.origin.y+_labelCustomName.frame.size.height, 180, _labelCustomName.frame.size.height)];
    [_labelDate setText:[NSDate stringDayOfDate:_event.dateDay]];
    [_labelDate setTextColor:[UIColor grayColor]];
    [_labelDate setFont:[UIFont systemFontOfSize:_labelCustomName.font.pointSize-3]];
    
    [self addSubview:_labelDate];
}

- (void) addLabelTimeWithViewSize:(CGSize)sizeView {
    CGFloat gap = 30;
    CGFloat x = _labelDate.frame.origin.x + _labelDate.frame.size.width + gap;
    
    _labelTime = [[UILabel alloc] initWithFrame:CGRectMake(x, _labelDate.frame.origin.y
                                                           , sizeView.width-x-gap, _labelDate.frame.size.height)];
    [_labelTime setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
    [_labelTime setText:[NSString stringWithFormat:@"%@ - %@", [NSDate stringTimeOfDate:_event.dateTimeBegin], [NSDate stringTimeOfDate:_event.dateTimeEnd]]];
    [_labelTime setTextAlignment:NSTextAlignmentRight];
    [_labelTime setTextColor:[UIColor grayColor]];
    [_labelTime setFont:_labelDate.font];
    
    [self addSubview:_labelTime];
}

@end
