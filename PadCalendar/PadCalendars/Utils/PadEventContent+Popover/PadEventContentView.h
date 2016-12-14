//
//  PadEventContentView.h
//  PadCalendar
//
//  Created by 葛岳 on 2016/12/14.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PadEvent.h"

@protocol PadEventContentViewProtocol <NSObject>

@required
- (void) showEditViewWithEvent:(PadEvent *) event;

@end

@interface PadEventContentView : UIView

@property (nonatomic, strong) id<PadEventContentViewProtocol> protocol;
@property (nonatomic, strong) UIButton *buttonEditPopover;

- (id) initWithFrame:(CGRect)frame event:(PadEvent *)event;

@end
