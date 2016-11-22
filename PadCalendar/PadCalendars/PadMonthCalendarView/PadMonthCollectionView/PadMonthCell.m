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
        
        _labelDay = [[UILabel alloc] initWithFrame:CGRectMake((_imageViewCircle.frame.size.width-20.)/2, (_imageViewCircle.frame.size.height-20.)/2, 20., 20.)];
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
    
}

#pragma mark - PadButtonWithEditAndDetailPopoversForMonthCell Protocol

- (void) saveEditedEvent:(PadEvent *)eventNew ofButton:(UIButton *)button {
    
}

- (void) deleteEventOfButton:(UIButton *)button {
    
}

@end
