//
//  PadEditEventViewController.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/12/16.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadEditEventViewController.h"

#import "PadEditEventView.h"
#import "PadCalendars.h"

@interface PadEditEventViewController () <PadEditEventViewProtocol>
@property (nonatomic, strong) PadEvent *event;
@end

@implementation PadEditEventViewController

#pragma mark - Lifecycle

- (id) initWithEvent:(PadEvent *)eventInit {

    if (!eventInit) {
        NSDateComponents *comp = [NSDate componentsOfCurrentDate];
        eventInit = [PadEvent new];
        eventInit.stringEventName = @"";
        eventInit.dateDay = [NSDate date];
        eventInit.dateTimeBegin = [NSDate dateWithHour:comp.hour min:comp.minute];
        eventInit.dateTimeEnd = [NSDate dateWithHour:comp.hour min:comp.minute+15];
    }
    _event = eventInit;
    
    CGSize size = CGSizeMake(300., 700.);
    PadEditEventView *viewEditor = [[PadEditEventView alloc] initWithFrame:CGRectMake(0., 0., size.width, size.height) event:eventInit];
    [viewEditor setProtocol:self];
    
    self.view = viewEditor;
    self.preferredContentSize = size;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PadEditEventView Protocol

- (void) saveEvent:(PadEvent *)event {
    if (_protocol && [_protocol respondsToSelector:@selector(saveEditedEvent:)]) {
        [_protocol saveEditedEvent:event];
    }
    [self removeThisView:nil];
}

- (void) deleteEvent:(PadEvent *)event {
    if (_protocol && [_protocol respondsToSelector:@selector(deleteEvent:)]) {
        [_protocol deleteEvent];
    }
    [self removeThisView:nil];
}

- (void) removeThisView:(UIView *)view {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
