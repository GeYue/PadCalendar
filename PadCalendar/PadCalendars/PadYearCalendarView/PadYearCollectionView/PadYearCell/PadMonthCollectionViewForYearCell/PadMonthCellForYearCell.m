//
//  PadMonthCellForYearCell.m
//  PadCalendar
//
//  Created by 葛岳 on 2016/10/31.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import "PadMonthCellForYearCell.h"

@interface PadMonthCellForYearCell ()

@property (nonatomic, strong) UIImageView *imageViewCircle;

@end

@implementation PadMonthCellForYearCell

#pragma mark - Lifecycle

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialize code
    }
    
    return self;
}

#pragma mark - Other methods

- (void) initLayout {
    if (!_labelDay) {
        _imageViewCircle = [[UIImageView alloc] initWithFrame:CGRectMake(0., 0., self.frame.size.width, self.frame.size.height)];
        [_imageViewCircle setContentMode:UIViewContentModeScaleAspectFit];
        
        [self addSubview:_imageViewCircle];
        
        _labelDay = [[UILabel alloc] initWithFrame:CGRectMake(0., 0., self.frame.size.width, self.frame.size.height)];
        [_labelDay setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_labelDay];
    }
    
    [_labelDay setText:@""];
    [_labelDay setTextColor:[UIColor blackColor]];
    [_imageViewCircle setImage:nil];
}

- (void) markAsCurrentDay {
    [_labelDay setTextColor:[UIColor whiteColor]];
    [_imageViewCircle setImage:[UIImage imageNamed:@"redCircle"]];
}

@end
