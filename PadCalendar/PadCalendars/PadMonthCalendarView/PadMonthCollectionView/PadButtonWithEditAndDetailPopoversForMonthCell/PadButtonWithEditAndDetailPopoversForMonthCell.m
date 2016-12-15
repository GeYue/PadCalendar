//
//  PadButtonWithEditAndDetailPopoversForMonthCell.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/11/22.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadButtonWithEditAndDetailPopoversForMonthCell.h"

#import "PadEventContentPopoverController.h"

@interface PadButtonWithEditAndDetailPopoversForMonthCell() <PadEventContentPopoverControllerProtocol>
@property (nonatomic, strong) PadEventContentPopoverController *popoverContentController;

@end

@implementation PadButtonWithEditAndDetailPopoversForMonthCell

#pragma mark - Lifecycle

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self){
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:12.]];
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        
        [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void) setEvent:(PadEvent *)event {
    _event = event;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

#pragma mark - Button Action

- (IBAction)buttonAction:(id)sender {
    if (_event) {
        _popoverContentController = [[PadEventContentPopoverController alloc] initWithEvent:_event];
        [_popoverContentController setProtocol:self];
        
        
    }
}

#pragma mark - PadEventContentPopoverController Protocol

- (void) showPopoverEditWithEvent:(PadEvent *)event {
    
}

@end
