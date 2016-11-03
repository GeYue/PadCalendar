//
//  PadYearCalendarView.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/24.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadYearCalendarView.h"
#import "PadDateManager.h"
#import "PadYearCollectionView.h"
#import "PadYearCollectionViewLayout.h"

#import "PadConstants.h"

@interface PadYearCalendarView () <PadYearCollectionViewProtocol>
@property (nonatomic, strong) PadYearCollectionView *collectionViewYear;
@end

@implementation PadYearCalendarView

#pragma mark - Lifecycle

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateChanged:) name:DATE_MANAGER_DATE_CHANGED object:nil];
        [self setBackgroundColor:[UIColor whiteColor]];

        _collectionViewYear = [[PadYearCollectionView alloc] initWithFrame:CGRectMake(SPACE_COLLECTIONVIEW_CELL_YEAR, SPACE_COLLECTIONVIEW_CELL_YEAR, self.frame.size.width-2*SPACE_COLLECTIONVIEW_CELL_YEAR, self.frame.size.height-2*SPACE_COLLECTIONVIEW_CELL_YEAR) collectionViewLayout:[PadYearCollectionViewLayout new]];
        [_collectionViewYear setProtocol:self];
        [self addSubview:_collectionViewYear];
        
        [self setAutoresizingMask:AR_WIDTH_HEIGHT];
        [_collectionViewYear setAutoresizingMask:AR_WIDTH_HEIGHT | AR_TOP_BOTTOM];
    }
    return self;
}

#pragma mark - Invalidate Layout

- (void) invalidateLayout {
    [_collectionViewYear.collectionViewLayout invalidateLayout];
}

#pragma mark - Notification

- (void) dateChanged:(NSNotification *)notification {
    [_collectionViewYear setContentOffset:CGPointMake(0., _collectionViewYear.frame.size.height) animated:NO];
    [_collectionViewYear reloadData];
}

#pragma mark - PadYearCollectionView Protocol

- (void) showMonthCalendar {
    if (_protocol && [_protocol respondsToSelector:@selector(showMonthCalendar)]) {
        [_protocol showMonthCalendar];
    }
}

@end
