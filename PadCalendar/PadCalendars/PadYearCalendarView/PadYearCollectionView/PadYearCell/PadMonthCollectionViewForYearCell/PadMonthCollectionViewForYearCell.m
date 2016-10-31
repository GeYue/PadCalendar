//
//  PadMonthCollectionViewForYearCell.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/31.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadMonthCollectionViewForYearCell.h"
#import "PadMonthCellForYearCell.h"
#import "PadHeaderMonthForYearCell.h"

#import "PadConstants.h"

@interface PadMonthCollectionViewForYearCell() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic) CGSize sizeOfCells;
@property (nonatomic, strong) NSMutableArray *arrayDates;
@property (nonatomic, strong) NSDate *dateFirstDayOfMonth;
@end

@implementation PadMonthCollectionViewForYearCell

#pragma mark - Lifecycle

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // initialize.
    }
    
    return self;
}

- (id) initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:[UICollectionViewLayout new]];
    if (self) {
        [self setUserInteractionEnabled:YES];
        [self setDataSource:self];
        [self setDelegate:self];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self registerClass:[PadMonthCellForYearCell class] forCellWithReuseIdentifier:REUSE_IDENTIFIER_MONTH_CELL];
        [self registerClass:[PadHeaderMonthForYearCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:REUSE_IDENTIFIER_MONTH_HEADER];
    }
    return self;
}

#pragma mark - UICollectionView DataSource



#pragma mark - UICollectionView Delegate



@end
