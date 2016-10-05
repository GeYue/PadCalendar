//
//  PadCalendarViewController.m
//  PadCalendar
//
//  Created by 葛岳 on 16/9/10.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadCalendarViewController.h"
#import "PadCalendars.h"

@interface PadCalendarViewController () <PadButtonAddEventWithPopoverProtocol>

@property (nonatomic, strong) UILabel *labelWithMonthAndYear;
@property (nonatomic, strong) NSArray *arrayButtons;
@property (nonatomic, strong) NSArray *arrayCalendars;

@property (nonatomic, strong) NSMutableDictionary *dictEvents;

@end

#define DATEMANAGER_DATE_CHANGED    @"com.GeYue.Developer.Padcalendar.DataeManager.DateChanged"
@implementation PadCalendarViewController

#pragma makr - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateChanged:) name:DATEMANAGER_DATE_CHANGED object:nil];
    
    [self customNavigationBarLayout];
    [self addCalendars];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Notifications

- (void) dateChanged:(NSNotification *)notification {
    
}

#pragma mark - Custom NavigatorBar

- (void) customNavigationBarLayout {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=7 ) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor lightGrayCustom]];
    
    [self addRightBarButtonItems];
    [self addLeftBarButtonItems];
}

- (void) addRightBarButtonItems {
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                  target:nil action:nil];
    fixedItem.width = 30;
    
    PadRedAndWhiteButton *buttonYear = [self calendarButtonWithTitle:@"Year"];
    PadRedAndWhiteButton *buttonMonth = [self calendarButtonWithTitle:@"Month"];
    PadRedAndWhiteButton *buttonWeek = [self calendarButtonWithTitle:@"Week"];
    PadRedAndWhiteButton *buttonDay = [self calendarButtonWithTitle:@"Day"];
    
    UIBarButtonItem *barButtonYear = [[UIBarButtonItem alloc] initWithCustomView:buttonYear];
    UIBarButtonItem *barButtonMonth = [[UIBarButtonItem alloc] initWithCustomView:buttonMonth];
    UIBarButtonItem *barButtonWeek = [[UIBarButtonItem alloc] initWithCustomView:buttonWeek];
    UIBarButtonItem *barButtonDay = [[UIBarButtonItem alloc] initWithCustomView:buttonDay];
    
    PadAddEventPopoverButton *buttonAdd = [[PadAddEventPopoverButton alloc] initWithFrame:CGRectMake(0., 0., 30., 44)];
    
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithCustomView:buttonAdd];
    
    [self.navigationItem setRightBarButtonItems:@[barButtonAdd, fixedItem, barButtonYear, barButtonMonth, barButtonWeek, barButtonDay]];
}

- (void) addLeftBarButtonItems {
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                  target:nil action:nil];
    fixedItem.width = 30;

    PadRedAndWhiteButton *buttonToday = [[PadRedAndWhiteButton alloc] initWithFrame:CGRectMake(0., 0., 80., 30)];
    [buttonToday addTarget:self action:@selector(buttonTodayAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonToday setTitle:@"Today" forState:UIControlStateNormal];
    UIBarButtonItem *barButtonToday = [[UIBarButtonItem alloc] initWithCustomView:buttonToday];
    
    _labelWithMonthAndYear = [[UILabel alloc] initWithFrame:CGRectMake(0., 0., 170., 30)];
    [self.labelWithMonthAndYear setTextColor:[UIColor redColor]];
    [self.labelWithMonthAndYear setFont:buttonToday.titleLabel.font];
    UIBarButtonItem *barButtonLabel = [[UIBarButtonItem alloc] initWithCustomView:self.labelWithMonthAndYear];
    
    [self.navigationItem setLeftBarButtonItems:@[barButtonLabel, fixedItem, barButtonToday]];
}

- (PadRedAndWhiteButton *) calendarButtonWithTitle:(NSString *)title {
    PadRedAndWhiteButton *button = [[PadRedAndWhiteButton alloc] initWithFrame:CGRectMake(0., 0., 80., 30.)];
    [button addTarget:self action:@selector(buttonYearMonthWeekDayAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

#pragma mark - Add Calendars

- (void) addCalendars {
    
}

#pragma mark - Button Action

- (IBAction)buttonYearMonthWeekDayAction:(id)sender {
    
}

- (IBAction)buttonTodayAction:(id)sender {
    
}

#pragma mark - PadButtonAddEventWithPopoverProtocol Protocol

- (void) addNewEvent:(PadEvent *)eventNew {
    NSMutableArray *arrayNew = [_dictEvents objectForKey:eventNew.dateDay];
    if (!arrayNew) {
        arrayNew = [[NSMutableArray alloc] init];
        [_dictEvents setObject:arrayNew forKey:eventNew.dateDay];
    }
    [arrayNew addObject:eventNew];
    
    [self setNewDictionary:_dictEvents];
}

#pragma mark - PadmonthCalendarView, PadWeekCalendarView, PadDayCalendarView Protocal

- (void) setNewDictionary:(NSDictionary *)dict {
    _dictEvents = (NSMutableArray *)dict;
    
    //[self.viewCalendarMonth setNewDictEvents:_dictEvents];
    //[self.viewCalendarWeek setNewDictEvents:_dictEvents];
    //[self.viewCalendarDay setNewDictEvents:_dictEvents];
    
    [self arrayUpdatedWithEvents];
}

- (void) arrayUpdatedWithEvents {
    NSMutableArray *arrayNew = [NSMutableArray new];
    
    NSArray *arrayKeys = self.dictEvents.allKeys;
    for (NSDate *date in arrayKeys) {
        NSArray *arrayOfDate = [self.dictEvents objectForKey:date];
        for (PadEvent *event in arrayOfDate) {
            [arrayNew addObject:event];
        }
    }
}
@end
