//
//  PadRedAndWhiteButton.m
//  PadCalendar
//
//  Created by 葛岳 on 16/9/10.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadRedAndWhiteButton.h"
#import "PadCalendars.h"

@implementation PadRedAndWhiteButton

- (id) initWithFrame:(CGRect)frame {
    self = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self) {
        [self setFrame:frame];
        
        [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateSelected];
     
        [self.layer setBorderColor:[UIColor redColor].CGColor];
        [self.layer setBorderWidth:1.];
    }
    return self;
}

- (void) setSelected:(BOOL)selected {
    self.selected = selected;
    if (selected) {
        [self.layer setBorderColor:[UIColor whiteColor].CGColor];
    } else {
        [self.layer setBorderColor:[UIColor redColor].CGColor];
    }
}
@end
