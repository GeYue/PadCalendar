//
//  PadEventContentPopoverController.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/12/14.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadEventContentPopoverController.h"

#import "PadEventContentView.h"

@interface PadEventContentPopoverController () <PadEventContentViewProtocol>
@property (nonatomic, strong) PadEvent *event;
@end

@implementation PadEventContentPopoverController

#pragma mark - Lifecycle

- (id) initWithEvent:(PadEvent *)eventInit {
    _event = eventInit;
    CGSize size = CGSizeMake(360, 130.);
    
    PadEventContentView *viewContent = [[PadEventContentView alloc] initWithFrame:CGRectMake(0., 0., size.width, size.height) event:eventInit];
    [viewContent setProtocol:self];
    
    self.view = viewContent;
    self.preferredContentSize = viewContent.frame.size;
    
    return self;
}

#pragma mark - PadEventContentView Protocol

- (void) showEditViewWithEvent:(PadEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (_protocol && [_protocol respondsToSelector:@selector(showPopoverEditWithEvent:)]) {
        [_protocol showPopoverEditWithEvent:event];
    }
}

@end
