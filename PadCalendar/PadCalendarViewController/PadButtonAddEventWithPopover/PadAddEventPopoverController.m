//
//  PadAddEventAlertController.m
//  PadCalendar
//
//  Created by 葛岳 on 16/9/12.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadAddEventPopoverController.h"
#import "UIColor+PadMoreColors.h"
#import "PadConstants.h"

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
    
    [self addButtonCancelWithCustomView:self.view];
    [self addButtonDoneWithCustomView:self.view];
    
    return self;
}


#pragma mark - Button Actions

- (IBAction)buttonCalcelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buttonDoneAction:(id)sender {
    
}

#pragma mark - Add Subviews

- (void) addButtonCancelWithCustomView:(UIView *)customView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, customView.frame.size.width, BUTTON_HEIGHT+30)];
    [view setBackgroundColor:[UIColor lightGrayCustom]];
    [customView addSubview:view];
    
    _buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self customLayoutOfButton:self.buttonCancel withTitle:@"Cancel"
                        action:@selector(buttonCalcelAction:) frame:CGRectMake(20, 0, 80, BUTTON_HEIGHT+30)];
    [view addSubview:_buttonCancel];
}

- (void) addButtonDoneWithCustomView:(UIView *)customView {
    _buttonDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [self customLayoutOfButton:self.buttonDone withTitle:@"Done"
                        action:@selector(buttonDoneAction:)
                         frame:CGRectMake(self.buttonCancel.superview.frame.size.width-80-10, self.buttonCancel.frame.origin.y, 80, self.buttonCancel.frame.size.height)];
    [self.buttonCancel.superview addSubview:self.buttonDone];
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

#pragma mark - Button Layout

- (void)customLayoutOfButton:(UIButton *)button withTitle:(NSString *)title action:(SEL)action frame:(CGRect)frame {
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:button.titleLabel.font.pointSize]];
    [button setFrame:frame];
    [button setContentMode:UIViewContentModeScaleAspectFit];
}

#pragma mark - UIGestureRecognizer Delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:self];
    
    return NO;
}

@end
