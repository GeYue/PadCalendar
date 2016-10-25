//
//  PadYearCollectionView.h
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/25.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PadYearCollectionViewProtocol <NSObject>
@required
- (void) showMonthCalendar;

@end

@interface PadYearCollectionView : UICollectionView

@property (nonatomic, strong) id<PadYearCollectionViewProtocol> protocol;

@end
