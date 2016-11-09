//
//  PadMonthCalendarView.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/11/9.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadMonthCalendarView.h"
#import "PadMonthCollectionView.h"
#import "PadDateManager.h"
#import "PadConstants.h"

#import "PadMonthHeaderView.h"
#import "PadMonthCollectionView.h"

@interface PadMonthCalendarView () <PadMonthCollectionViewProtocol>
@property (nonatomic, strong) PadMonthCollectionView *collectionViewMonth;
@end

@implementation PadMonthCalendarView

#pragma mark - Lifecycle

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateChanged:) name:DATE_MANAGER_DATE_CHANGED object:nil];
        [self setBackgroundColor:[UIColor whiteColor]];
        
        PadMonthHeaderView *headerView = [[PadMonthHeaderView alloc] initWithFrame:CGRectMake(0., 0., self.frame.size.width, HEADER_HEIGHT_MONTH)];
        [self addSubview:headerView];
        
        _collectionViewMonth = [[PadMonthCollectionView alloc] initWithFrame:CGRectMake(0., HEADER_HEIGHT_MONTH, self.frame.size.width, self.frame.size.height-HEADER_HEIGHT_MONTH) collectionViewLayout:[UICollectionViewLayout new]];
        [_collectionViewMonth setProtocol:self];
        [self addSubview:_collectionViewMonth];
        
        [self setAutoresizingMask:AR_WIDTH_HEIGHT];
        [_collectionViewMonth setAutoresizingMask:AR_WIDTH_HEIGHT | AR_TOP_BOTTOM];
        [headerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    }
    
    return self;
}

- (void) setDictEvents:(NSMutableDictionary *)dictEvents {
    _dictEvents = dictEvents;
    
    [_collectionViewMonth setDictEvents:dictEvents];
    [_collectionViewMonth reloadData];
}

#pragma mark - Invaliate Layout

- (void) invalidateLayout {
    [_collectionViewMonth.collectionViewLayout invalidateLayout];
    [_collectionViewMonth reloadData];
}

#pragma mark - PadMonthCalendarVie Notification

- (void) dateChanged:(NSNotification *)not {
    [_collectionViewMonth setContentOffset:CGPointMake(0., _collectionViewMonth.frame.size.height) animated:NO];
    [_collectionViewMonth reloadData];
}

#pragma mark - PadMonthCollectionView Protocol

- (void) setNewDictionary:(NSDictionary *)dict {
    if (_protocol && [_protocol respondsToSelector:@selector(setNewDictionary:)]) {
        [_protocol setNewDictionary:dict];
    }
}

@end
