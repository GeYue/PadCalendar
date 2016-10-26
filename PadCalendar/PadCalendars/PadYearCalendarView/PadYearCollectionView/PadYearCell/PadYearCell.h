//
//  PadYearCell.h
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/25.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PadYearCellProtocol <NSObject>

@required
- (void) showMonthCalendar;

@end

@interface PadYearCell : UICollectionViewCell

@property (nonatomic, strong) id<PadYearCellProtocol> protocol;
@property (nonatomic, strong) NSDate *date;

- (void) initLayout;

@end
