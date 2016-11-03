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
#import "PadCalendars.h"

#import "PadDateManager.h"

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
    self = [super initWithFrame:frame collectionViewLayout:[UICollectionViewFlowLayout new]];
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

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    _arrayDates = [[NSMutableArray alloc] init];
    
    NSDateComponents *compDateManager = [NSDate componentsOfDate:_date];
    _dateFirstDayOfMonth = [NSDate dateWithYear:compDateManager.year month:compDateManager.month day:1];
 
    long lastDayMonth = [_dateFirstDayOfMonth numberOfDaysInMonthCount];
    long numOfCellsInCollection = [_dateFirstDayOfMonth numberOfWeeksInMonthCount] * 7;
    
    for (long i=1-(compDateManager.weekday-1),j=numOfCellsInCollection-(compDateManager.weekday-1); i<=j; i++) {
        [_arrayDates addObject:(i >= 1 && i <= lastDayMonth) ? [NSDate dateWithYear:compDateManager.year month:compDateManager.month day:i] : [NSNull null]];
    }

    _sizeOfCells = CGSizeMake(self.frame.size.width/7, (self.frame.size.height-50.)/6);
    return _arrayDates.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PadMonthCellForYearCell *cell = (PadMonthCellForYearCell *) [collectionView dequeueReusableCellWithReuseIdentifier:REUSE_IDENTIFIER_MONTH_CELL forIndexPath:indexPath];
    
    [cell initLayout];
    
    id obj = [_arrayDates objectAtIndex:indexPath.row];
    if (obj != [NSNull null]) {
        NSDate *dateCell = (NSDate *) obj;
        NSDateComponents *components = [NSDate componentsOfDate:dateCell];
        [cell.labelDay setText:[NSString stringWithFormat:@"%li", (long)[components day]]];
        
        if ([NSDate isTheSameDateTheCompA:components compB:[NSDate compoentsOfCurrentDate]]) {
            [cell markAsCurrentDay];
        }
    }
    
    return cell;
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reuseView = nil;
    
    if (UICollectionElementKindSectionHeader == kind) {
        PadHeaderMonthForYearCell *headerView = (PadHeaderMonthForYearCell *) [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:REUSE_IDENTIFIER_MONTH_HEADER forIndexPath:indexPath];
        [headerView setDate:_date];
        [headerView addWeekLabelWithSizeOfCells:_sizeOfCells];
        
        reuseView = headerView;
    }
    
    return reuseView;
}

#pragma mark - UICollectionView Delegate

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id obj = [_arrayDates objectAtIndex:indexPath.row];
    if (obj != [NSNull null] && _protocol && [_protocol respondsToSelector:@selector(showMonthCalendar)]) {
        [[PadDateManager sharedManager] setCurrentDate:(NSDate *) obj];
        [_protocol showMonthCalendar];
    }
}


#pragma mark - UICollectionViewDelegateFlowlayout

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _sizeOfCells;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize headerViewSize = CGSizeMake(self.frame.size.width, 50.);
    return headerViewSize;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.;
}

@end
