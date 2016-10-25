//
//  PadYearCollectionViewLayout.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/25.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadYearCollectionViewLayout.h"

@implementation PadYearCollectionViewLayout

- (CGSize) collectionViewContentSize {
    return CGSizeMake(self.collectionView.frame.size.width, 3*self.collectionView.frame.size.height);
}

@end
