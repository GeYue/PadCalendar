//
//  PadAddEventAlertController.m
//  PadCalendar
//
//  Created by 葛岳 on 16/9/12.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadAddEventPopoverController.h"
#import "UIColor+PadMoreColors.h"

@interface PadAddEventPopoverController ()

@property (nonatomic, strong) UIButton *buttonCancel;
@property (nonatomic, strong) UIButton *buttonDone;
@property (nonatomic, strong) UILabel *labelEventName;

@end

@implementation PadAddEventPopoverController

#pragma mark - Lifecycle

- (id) initPopover {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0., 0., 300., 700.)];
    [self.view setBackgroundColor:[UIColor lightGrayCustom]];
    [self.view.layer setBorderColor:[UIColor lightGrayCustom].CGColor];
    [self.view.layer setBorderWidth:2.];
    
    return self;
}


#pragma mark - Button Actions

- (IBAction)buttonCalcelAction:(id)sender {

}

- (IBAction)buttonDoneAction:(id)sender {
    
}

#pragma mark - Add Subviews

- (void) addButtonCancelWithCustomView:(UIView *)customView {
    
}

- (void) addButtonDoneWithCustomView:(UIView *)customView {
    
}

- (void) addSearchBarWithCustomView:(UIView *)customView {
    
}

- (void) addButtonDateWithCustomView:(UIView *)customView {
    
}

- (void) addButtonTimeBeginWithCustomView:(UIView *)customView {
    
}

- (void) addButtonTimeEndWithCustomView:(UIView *)customView {
    
}

- (void) addTableViewGuestsWithCustomView:(UIView *)customView {
    
}

#pragma mark - UIGestureRecognizer Delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:self];
    
    return NO;
}

@end
