//
//  PadMonthHeaderView.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/11/9.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadMonthHeaderView.h"
#import "PadConstants.h"

@implementation PadMonthHeaderView

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayColor = @[[UIColor grayColor], [UIColor blackColor], [UIColor blackColor], [UIColor blackColor], [UIColor blackColor], [UIColor blackColor], [UIColor grayColor]];
        CGFloat width = (self.frame.size.width-6*SPACE_COLLECTIONVIEW_CELL)/7.;
        
        for (int i=0; i<[arrayWeekAbrev count]; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*(width+SPACE_COLLECTIONVIEW_CELL), 0., width-5, self.frame.size.height)];
            [label setTextAlignment:NSTextAlignmentRight];
            [label setText:[arrayWeekAbrev objectAtIndex:i]];
            [label setTextColor:[arrayColor objectAtIndex:i]];
            [label setFont:[UIFont boldSystemFontOfSize:label.font.pointSize]];
            [label setAutoresizingMask:AR_LEFT_RIGHT | UIViewAutoresizingFlexibleWidth];
            
            [self addSubview:label];
        }
    }
    
    return self;
}

@end
