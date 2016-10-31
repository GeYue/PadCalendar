//
//  PadYearCollectionView.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/25.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadYearCollectionView.h"
#import "PadYearCell.h"

#import "PadConstants.h"
#import "PadCalendars.h"

#import "PadDateManager.h"

@interface PadYearCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, PadYearCellProtocol>
@property (nonatomic) CGFloat lastContentOffset;
@end

@implementation PadYearCollectionView

#pragma mark - Lifecycle

- (id) initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self setDataSource:self];
        [self setDelegate:self];
        
        [self registerClass:[PadYearCell class] forCellWithReuseIdentifier:REUSE_IDENTIFIER_MONTH_CELL];
        
        [self setScrollEnabled:YES];
        [self setPagingEnabled:YES];
        
        [self setShowsVerticalScrollIndicator:NO];
    }
    return self;
}

#pragma mark - UICollectionView DataSource

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PadYearCell *cell = (PadYearCell *) [collectionView dequeueReusableCellWithReuseIdentifier:REUSE_IDENTIFIER_MONTH_CELL
                                                                                  forIndexPath:indexPath];
    [cell setProtocol:self];
    [cell initLayout];
    
    [cell setDate:[NSDate dateWithYear:([[PadDateManager sharedManager] currentDate].componentsOfDate.year+indexPath.section-1) month:indexPath.row+1 day:1]];
    return cell;
}

#pragma mark - UICollectionView Delegate Layout

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isLandscape = (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation));
    
    NSInteger lines = isLandscape ? 3 : 4;
    NSInteger columes = isLandscape ? 4 : 3;
    
    CGSize sizeOfCell = CGSizeMake((self.frame.size.width-(columes-1)*SPACE_COLLECTIONVIEW_CELL_YEAR)/columes,
                                   (self.frame.size.height-(lines-1)*SPACE_COLLECTIONVIEW_CELL_YEAR)/lines);
    
    return sizeOfCell;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return SPACE_COLLECTIONVIEW_CELL_YEAR;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.;
}

#pragma UIScallView Delegate

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _lastContentOffset = scrollView.contentOffset.y;
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_lastContentOffset > scrollView.contentOffset.y) {
        [self changeYear:NO];
    } else if (_lastContentOffset < scrollView.contentOffset.y) {
        [self changeYear:YES];
    }
}

#pragma mark - UICollectionView Delegate

- (void) showMonthCalendar {
    if (_protocol && [_protocol respondsToSelector:@selector(showMonthCalendar)]) {
        [_protocol showMonthCalendar];
    }
}

#pragma mark - Other methods

- (void) changeYear:(BOOL)isUp {
    NSDateComponents *dateComponent = [[NSDateComponents alloc] init];
    [dateComponent setYear:(isUp ? 1 : -1)];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateByAddingComponents:dateComponent toDate:[[PadDateManager sharedManager] currentDate] options:0];
    
    [[PadDateManager sharedManager] setCurrentDate:date];
}

@end
