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

@interface PadYearCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation PadYearCollectionView

#pragma mark - Lifecycle

- (id) initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self =  [super initWithFrame:frame collectionViewLayout:layout];
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
    
    //cell setDate:[NSDate dateWithYear:([]) month:<#(NSInteger)#> day:<#(NSInteger)#>]
    return cell;
}

@end
