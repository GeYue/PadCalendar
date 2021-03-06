//
//  PadSearchBarWithAutoComplete.h
//  PadCalendar
//
//  Created by 葛岳 on 2016/9/26.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PadSearchBarWithAutoComplete : UISearchBar

@property (nonatomic, strong) NSMutableArray *arrayOfTableView;
@property (nonatomic, strong) UITableView *tableViewCustom;
@property (nonatomic, strong) NSString *stringEventName;
@property (nonatomic, strong) NSNumber *numEventID;

- (id) initWithDateAndFrame:(NSDate*)date Frame:(CGRect)frame;
- (void) closeKeyboardAndTableView;
@end
