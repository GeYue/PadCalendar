//
//  PadYearCell.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/25.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadYearCell.h"
#import "PadMonthCollectionViewForYearCell.h"

@interface PadYearCell() <PadMonthCollectionViewForYearCellProtocol>
@property (nonatomic, strong) PadMonthCollectionViewForYearCell *collectionView;
@end

@implementation PadYearCell

#pragma mark - Lifecycle

- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //initialize 
    }
    return self;
}

#pragma mark - Other Method

- (void) initLayout {
    if (!_collectionView) {
        _collectionView = [[PadMonthCollectionViewForYearCell alloc] initWithFrame:CGRectMake(0., 0., self.frame.size.width, self.frame.size.height) collectionViewLayout:[UICollectionViewLayout new]];
        [_collectionView setProtocol:self];
        [self addSubview:_collectionView];
    }
}

- (void) setDate:(NSDate *)date {
    _date = date;
    
    [_collectionView setDate:date];
    [_collectionView reloadData];
}

#pragma mark - PadMonthCollectionViewForYearCellProtocol

- (void) showMonthCalendar {
    if (_protocol && [_protocol respondsToSelector:@selector(showMonthCalendar)]) {
        [_protocol showMonthCalendar];
    }
}

@end
