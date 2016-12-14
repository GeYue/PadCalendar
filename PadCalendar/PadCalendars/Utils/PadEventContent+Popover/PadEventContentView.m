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

    
}

- (void) addLabelCustomnameWithViewSize:(CGSize)sizeView {
    
}

- (void) addLabelDateWithViewSize:(CGSize)sizeView {
    
}

- (void) addLabelTimeWithViewSize:(CGSize)sizeView {
    
}

@end
