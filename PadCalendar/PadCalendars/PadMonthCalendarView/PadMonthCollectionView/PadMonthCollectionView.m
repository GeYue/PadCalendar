//
//  PadMonthCollectionView.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/11/9.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadMonthCollectionView.h"
#import "PadMonthCell.h"
#import "PadMonthCollectionViewFlowLayout.h"

#import "PadCalendars.h"
#import "PadDateManager.h"

@interface PadMonthCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, PadMonthCellProtocol>

@property (nonatomic) CGFloat lastContentOffset;
@property (nonatomic, strong) NSMutableArray *arraySizeOfCells;
@property (nonatomic, strong) NSMutableArray *arrayWithFirstDay;
@property (nonatomic, strong) NSArray *dispWeeksArray;

@end

@implementation PadMonthCollectionView

#pragma mark - Lifecycle

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialize code.
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:[PadMonthCollectionViewFlowLayout new]];
    if (self) {
        [self setDataSource:self];
        [self setDelegate:self];
        
        [self setBackgroundColor:[UIColor lightGrayCustom]];
        [self registerClass:[PadMonthCell class] forCellWithReuseIdentifier:REUSE_IDENTIFIER_MONTH_CELL];
        
        [self setScrollEnabled:YES];
        [self setPagingEnabled:YES];
        [self setShowsVerticalScrollIndicator:NO];
        
        _dispWeeksArray = @[[NSMutableArray new], [NSMutableArray new], [NSMutableArray new]];
        _arraySizeOfCells = [[NSMutableArray alloc] initWithObjects:[NSValue valueWithCGSize:CGSizeZero], [NSValue valueWithCGSize:CGSizeZero], [NSValue valueWithCGSize:CGSizeZero], nil];
        _arrayWithFirstDay = [[NSMutableArray alloc] initWithObjects:[NSDate new], [NSDate new], [NSDate new], nil];
    }
    return self;
}

#pragma mark - CollectionView DataSource

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSMutableArray *arrayDates = [_dispWeeksArray objectAtIndex:section];
    [arrayDates removeAllObjects];
    
    NSDateComponents *compDateManager = [NSDate componentsOfDate:[[PadDateManager sharedManager] currentDate]];
    compDateManager.month += section - 1;
    NSDate *dateFirstDayOfMonth = [NSDate dateWithYear:compDateManager.year month:compDateManager.month day:1];
    [_arrayWithFirstDay replaceObjectAtIndex:section withObject:dateFirstDayOfMonth];
    NSDateComponents *componentsFirstDayOfMonth = [NSDate componentsOfDate:dateFirstDayOfMonth];
    
    long lastDayMonth = [dateFirstDayOfMonth numberOfDaysInMonthCount];
    long numOfCellsInCollection = [dateFirstDayOfMonth numberOfWeeksInMonthCount] * 7;
    
    for (long i=1-(componentsFirstDayOfMonth.weekday-1),j=numOfCellsInCollection-(componentsFirstDayOfMonth.weekday-1); i<=j; i++) {
        if (i >= 1 && i <= lastDayMonth) {
            [arrayDates addObject:[NSDate dateWithYear:compDateManager.year month:compDateManager.month day:i]];
        } else {
            [arrayDates addObject:[NSNull null]];
        }
    }
    
    CGSize sizeOfCells = CGSizeMake((self.frame.size.width-7*SPACE_COLLECTIONVIEW_CELL)/7, (self.frame.size.height-([dateFirstDayOfMonth numberOfWeeksInMonthCount]-1)*SPACE_COLLECTIONVIEW_CELL-SPACE_COLLECTIONVIEW_CELL)/[dateFirstDayOfMonth numberOfWeeksInMonthCount]);
    [_arraySizeOfCells replaceObjectAtIndex:section withObject:[NSValue valueWithCGSize:sizeOfCells]];
    
    return [arrayDates count];
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSMutableArray *arrayDates = [_dispWeeksArray objectAtIndex:indexPath.section];
    
    PadMonthCell *cell = (PadMonthCell *) [collectionView dequeueReusableCellWithReuseIdentifier:REUSE_IDENTIFIER_MONTH_CELL forIndexPath:indexPath];
    [cell initLayout];
    [cell setProtocol:self];
    
    if (0 == indexPath.row % 7 || 0 == (indexPath.row + 1) % 7) {
        [cell markAsWeekend];
    }
    
    id object = [arrayDates objectAtIndex:indexPath.row];
    if (object != [NSNull null]) {
        NSDate *date = (NSDate *) object;
        NSDateComponents *components = [NSDate componentsOfDate:date];

        [cell setArrayEvents:[_dictEvents objectForKey:date]];
        [cell.labelDay setText:[NSString stringWithFormat:@"%li", (long)[components day]]];
        
        if ([NSDate isTheSameDateTheCompA:components compB:[NSDate componentsOfCurrentDate]]) {
            [cell markAsCurrentDay];
        }
    }
    return cell;
}

#pragma mark - UICollectionView Delegate FlowLayout

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [[_arraySizeOfCells objectAtIndex:indexPath.section] CGSizeValue];
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize headViewSize = CGSizeMake(self.frame.size.width, SPACE_COLLECTIONVIEW_CELL);
    
    return headViewSize;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return SPACE_COLLECTIONVIEW_CELL;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return SPACE_COLLECTIONVIEW_CELL;
}

#pragma mark - UIScrollView Delegate

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _lastContentOffset = scrollView.contentOffset.y;
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_lastContentOffset > scrollView.contentOffset.y) {
        [self changeYearDirectionIsUp:NO];
    } else if (_lastContentOffset < scrollView.contentOffset.y) {
        [self  changeYearDirectionIsUp:YES];
    }
}

#pragma mark - Other Method

- (void) changeYearDirectionIsUp:(BOOL)isUp {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:isUp?1:-1];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:[_arrayWithFirstDay objectAtIndex:1] options:0];
    
    [[PadDateManager sharedManager] setCurrentDate:newDate];
}

#pragma mark - PadMonthCell Protocol

- (void) saveEditedEvent:(PadEvent *)eventNew ofCell:(UICollectionViewCell *)cell atIndex:(NSInteger)index {
    NSDate *dateNew = eventNew.dateDay;
    NSMutableArray *arrayNew = [_dictEvents objectForKey:dateNew];
    if (!arrayNew) {
        arrayNew = [NSMutableArray new];
        [_dictEvents setObject:arrayNew forKey:dateNew];
    }
    [arrayNew addObject:eventNew];
}

- (void) deleteEventOfCell:(UICollectionViewCell *)cell atIndex:(NSInteger)intIndex {
    NSMutableArray *arrayDates = [_dispWeeksArray objectAtIndex:[self indexPathForCell:cell].section];
    
    NSIndexPath *index = [self indexPathForCell:cell];
    NSDate *date = [arrayDates objectAtIndex:index.row];
    NSMutableArray *arrayDict = [_dictEvents objectForKey:date];
    
    [arrayDict removeObjectAtIndex:intIndex];
    if (arrayDict.count == 0) {
        [_dictEvents removeObjectForKey:date];
    }
    
    if (_protocol && [_protocol respondsToSelector:@selector(setNewDictionary:)]) {
        [_protocol setNewDictionary:_dictEvents];
    } else {
        [self reloadData];
    }
}

@end
