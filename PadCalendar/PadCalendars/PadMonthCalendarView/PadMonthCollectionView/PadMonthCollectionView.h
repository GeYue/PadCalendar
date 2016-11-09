//
//  PadMonthCollectionView.h
//  PadCalendar
//
//  Created by 葛岳 on 2016/11/9.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PadMonthCollectionViewProtocol <NSObject>

@required
- (void) setNewDictionary:(NSDictionary *)dict;

@end

@interface PadMonthCollectionView : UICollectionView

@property (nonatomic, strong) id<PadMonthCollectionViewProtocol> protocol;
@property (nonatomic, strong) NSMutableDictionary *dictEvents;

@end
