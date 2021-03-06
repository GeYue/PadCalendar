//
//  PadCalendarViewController.h
//  PadCalendar
//
//  Created by 葛岳 on 16/9/10.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PadCalendarViewControllerProtocol <NSObject>

@required
- (void) arrayUpdatedWithAllEvents:(NSMutableArray *)arrayUpdated;

@end

@interface PadCalendarViewController : UIViewController

@property (nonatomic, strong) id<PadCalendarViewControllerProtocol> protocol;
@property (nonatomic, strong) NSMutableArray *arrayWithEvents;

@end
