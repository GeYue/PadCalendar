//
//  PadConstants.h
//  PadCalendar
//
//  Created by 葛岳 on 16/9/16.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#ifndef PadConstants_h
#define PadConstants_h

typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;

#define BUTTON_HEIGHT 44.
#define REUSE_IDENTIFIER_MONTH_CELL @"monthCell"


#define dictWeekNumberName @{@1:@"Sunday", @2:@"Monday", @3:@"Tuesday", @4:@"Wednesday", @5:@"Thursday", @6:@"Friday", @7:@"Saturday"}
#define arrayWeekAbrev @[@"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat"]
#define arrayMonthName @[@"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December"]
#define arrayMonthNameAbrev @[@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec"]


#define SPACE_COLLECTIONVIEW_CELL_YEAR 30.
#define SPACE_COLLECTIONVIEW_CELL 2.
#define HEADER_HEIGHT_MONTH 32.
#define HEADER_HEIGHT_SCROLL 100.
#define REUSE_IDENTIFIER_MONTH_CELL @"monthCell"
#define REUSE_IDENTIFIER_MONTH_HEADER @"headerCollection"

#define AR_WIDTH_HEIGHT UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
#define AR_TOP_BOTTOM UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
#define AR_LEFT_RIGHT UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin
#define AR_LEFT_BOTTOM UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin

#endif /* PadConstants_h */
