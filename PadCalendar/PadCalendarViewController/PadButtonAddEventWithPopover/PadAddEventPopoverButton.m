//
//  PadAddEventPopoverButton.m
//  PadCalendar
//
//  Created by 葛岳 on 16/9/10.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadAddEventPopoverButton.h"
#import "PadAddEventPopoverController.h"

@interface PadAddEventPopoverButton ()

@property (nonatomic, strong) PadAddEventPopoverController *popoverControllerAdd;

@end

@implementation PadAddEventPopoverButton

#pragma mark - Lifecycle

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:30.]];
        [self setTitle:@"+" forState:UIControlStateNormal];
        
        [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

#pragma mark - Button Action

- (IBAction)buttonAction:(id)sender {
    _popoverControllerAdd = [[PadAddEventPopoverController alloc] initPopover];
    self.popoverControllerAdd.modalPresentationStyle = UIModalPresentationPopover;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.popoverControllerAdd
                                                                                 animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [self.popoverControllerAdd popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    //popController.delegate = self;
    
    UIButton *button = (UIButton *)sender;
    popController.sourceView = sender;
    popController.sourceRect = CGRectMake(0, 0, button.frame.size.width, button.frame.size.height);
}

@end
