//
//  PadHeaderMonthForYearCell.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/31.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadHeaderMonthForYearCell.h"

#import "PadConstants.h"
#import "PadCalendars.h"

@interface PadHeaderMonthForYearCell ()

@property (nonatomic, strong) UILabel *labelTitle;

@end

@implementation PadHeaderMonthForYearCell

#pragma mark - Lifecycle
- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialize Code...
    }
    return self;
}

#pragma mark - Other methods

- (void) addWeekLabelWithSizeOfCells:(CGSize)sizeOfCells {
    if (!_labelTitle) {
        CGFloat height = self.frame.size.height/4.;
        _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0., 0., self.frame.size.width, 3*height)];
        [_labelTitle setTextColor:[UIColor redColor]];
        [self addSubview:_labelTitle];
        
        for (int i=0; i<[arrayWeekAbrev count]; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*sizeOfCells.width, _labelTitle.frame.size.height, sizeOfCells.width, height)];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setText:[arrayWeekAbrev objectAtIndex:i]];
            [label setTextColor:[UIColor blackColor]];
            [label setFont:[UIFont boldSystemFontOfSize:label.font.pointSize-5]];
            
            [self addSubview:label];
        }
    }
    
    [_labelTitle setText:[[arrayMonthNameAbrev objectAtIndex:(_date.componentsOfDate.month-1)] uppercaseString]];
}

@end
