//
//  PadSearchBarWithAutoComplete.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/9/26.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadSearchBarWithAutoComplete.h"
#import "PadConstants.h"
#import "PadCalendars.h"
@interface PadSearchBarWithAutoComplete() <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *arrayWithDayEvents;

@end


@implementation PadSearchBarWithAutoComplete

#pragma mark - Lifecycle

- (id) initWithDateAndFrame:(NSDate*)date Frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        NSString *strDateKey = (date) ? [dateFormatter stringFromDate:date] : @"";
        
        _arrayOfTableView = [[NSMutableArray alloc] init];
        _arrayWithDayEvents = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"appEvents"] objectForKey:strDateKey] mutableCopy];
        if (!_arrayWithDayEvents) {
            _arrayWithDayEvents = [[NSMutableArray alloc] init];
        }
        
        _tableViewCustom = [[UITableView alloc] init];
        [_tableViewCustom registerClass:[UITableViewCell class] forCellReuseIdentifier:REUSE_IDENTIFIER_MONTH_CELL];
        [_tableViewCustom setDataSource:self];
        [_tableViewCustom setDelegate:self];
     
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardShown:)
                                                     name:UIKeyboardDidShowNotification
                                                   object:nil];
        [self setDelegate:self];
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
        [self setPlaceholder:@"CustomEvent"];
        NSArray *array = [NSArray arrayWithObjects:[PadSearchBarWithAutoComplete class], nil];
        [[UITextField appearanceWhenContainedInInstancesOfClasses:array] setFont:[UIFont systemFontOfSize:18.]];
        [[UITextField appearanceWhenContainedInInstancesOfClasses:array] setTextAlignment:NSTextAlignmentCenter];
    }
    return self;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - NSNotificationCenter Method

- (void) keyboardShown:(NSNotification *)notification {
    if (!_tableViewCustom.superview) {
        [self.superview addSubview:_tableViewCustom];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger intRows = [self.arrayOfTableView count];
    CGFloat height = 5 * BUTTON_HEIGHT;
    if (intRows < 5) {
        height = intRows * BUTTON_HEIGHT;
    }
    [self.tableViewCustom setFrame:CGRectMake(self.frame.origin.x,
                                              self.frame.origin.y+self.frame.size.height,
                                              self.frame.size.width,
                                              height)];
    return intRows;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSE_IDENTIFIER_MONTH_CELL];

    [cell setBackgroundColor:[UIColor lightGrayCustom]];
    PadEvent *event = [self.arrayOfTableView objectAtIndex:indexPath.row];
    cell.textLabel.text = event.stringEventName;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PadEvent *event = [self.arrayOfTableView objectAtIndex:indexPath.row];
    if (event) {
        [self setStringEventName:event.stringEventName];
        [self setNumEventID:event.numEventID];
        [self setText:event.stringEventName];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self closeKeyboardAndTableView];
}

#pragma mark - UISearchBarDelegate

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.arrayOfTableView removeAllObjects];
    if ([searchText length] != 0) {
        [self updateArrayOfTableViewWithText:searchText];
        
        if (0 == self.arrayOfTableView.count) {
            self.stringEventName = searchBar.text;
        }
    }
    [self.tableViewCustom reloadData];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self closeKeyboardAndTableView];
}

#pragma mark - Close keyboard & tableview

- (void) closeKeyboardAndTableView {
    [self resignFirstResponder];
    [self.tableViewCustom removeFromSuperview];
    [self.tableViewCustom reloadData];
}

#pragma mark - Update Array of TableView

-(void) updateArrayOfTableViewWithText:(NSString *)searchText {
    for (id arrayNode in _arrayWithDayEvents) {
        PadEvent *event = (PadEvent *) [NSKeyedUnarchiver unarchiveObjectWithData:arrayNode];
        NSString *string = event.stringEventName;
        NSRange r = [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (r.location != NSNotFound) {
            [self.arrayOfTableView addObject:event];
        }
    }
}

@end
