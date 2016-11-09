//
//  PadCalendarViewController.m
//  PadCalendar
//
//  Created by 葛岳 on 16/9/10.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadCalendarViewController.h"
#import "PadCalendars.h"
#import "PadDateManager.h"

#import "PadYearCalendarView.h"

@interface PadCalendarViewController () <PadButtonAddEventWithPopoverProtocol, PadYearCalendarViewProtocol>

@property (nonatomic) BOOL boolYearViewIsShowing;

@property (nonatomic, strong) UILabel *labelWithMonthAndYear;
@property (nonatomic, strong) NSArray *arrayButtons;
@property (nonatomic, strong) NSArray *arrayCalendars;

@property (nonatomic, strong) NSMutableDictionary *dictEvents;

@property (nonatomic, strong) PadYearCalendarView *viewCalendarYear;

@property (nonatomic) BOOL boolDidLoad;

@end

@implementation PadCalendarViewController

#pragma makr - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateChanged:) name:DATE_MANAGER_DATE_CHANGED object:nil];
    
    [self customNavigationBarLayout];
    [self addCalendars];
    [self buttonYearMonthWeekDayAction:[_arrayButtons objectAtIndex:0]];
    
    self.dictEvents = [[NSMutableDictionary alloc] init];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!_boolDidLoad) {
        _boolDidLoad = YES;
        [self buttonTodayAction:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Notifications

- (void) dateChanged:(NSNotification *)notification {
    [self updateLabelWithMonthAndYear];
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
    [buttonAdd setProtocol:self];
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithCustomView:buttonAdd];
    
    _arrayButtons = @[buttonYear, buttonMonth, buttonWeek, buttonDay];
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
    CGRect frame = CGRectMake(0., 0., self.view.frame.size.width, self.view.frame.size.height);
    
    _viewCalendarYear = [[PadYearCalendarView alloc] initWithFrame:frame];
    [_viewCalendarYear setProtocol:self];
    [self.view addSubview: _viewCalendarYear];
    
    _arrayCalendars = @[_viewCalendarYear];
}

#pragma mark - Button Action

- (IBAction)buttonYearMonthWeekDayAction:(id)sender {
    long index = [_arrayButtons indexOfObject:sender];
    
    [self.view bringSubviewToFront:[_arrayCalendars objectAtIndex:index]];
    
    for (UIButton *button in _arrayButtons) {
        button.selected = (button == sender);
    }
    
    _boolYearViewIsShowing = (index == 0);
    [self updateLabelWithMonthAndYear];
    
}

- (IBAction)buttonTodayAction:(id)sender {
    [[PadDateManager sharedManager] setCurrentDate:[NSDate dateWithYear:[NSDate componentsOfCurrentDate].year
                                                                  month:[NSDate componentsOfCurrentDate].month
                                                                    day:[NSDate componentsOfCurrentDate].day]];
}

- (void)updateLabelWithMonthAndYear {
    
    NSDateComponents *comp = [NSDate componentsOfDate:[[PadDateManager sharedManager] currentDate]];
    NSString *string = _boolYearViewIsShowing ? [NSString stringWithFormat:@"%li", (long)comp.year] : [NSString stringWithFormat:@"%@ %li", [arrayMonthName objectAtIndex:comp.month-1], (long)comp.year];
    [_labelWithMonthAndYear setText:string];
}

#pragma mark - PadButtonAddEventWithPopoverProtocol Protocol

- (void) addNewEvent:(PadEvent *)eventNew {
    NSMutableArray *arrayNew = [_dictEvents objectForKey:eventNew.dateDay];
    if (!arrayNew) {
        arrayNew = [[NSMutableArray alloc] init];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        NSString *strDateKey = [dateFormatter stringFromDate:eventNew.dateDay];
        [_dictEvents setObject:arrayNew forKey:strDateKey];
    }
    NSData *encodeEvent = [NSKeyedArchiver archivedDataWithRootObject:eventNew];
    [arrayNew addObject:encodeEvent];
    [[NSUserDefaults standardUserDefaults] setObject:self.dictEvents forKey:@"appEvents"];
    [self setNewDictionary:_dictEvents];
}

#pragma mark - PadmonthCalendarView, PadWeekCalendarView, PadDayCalendarView Protocal

- (void) setNewDictionary:(NSDictionary *)dict {
    
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

- (void) showMonthCalendar {
    [self buttonYearMonthWeekDayAction:[_arrayButtons objectAtIndex:1]];
}

@end
