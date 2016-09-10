//
//  UIImage+PadCustomMethods.h
//  PadCalendar
//
//  Created by 葛岳 on 16/9/10.
//  Copyright © 2016年 GeYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (PadImageMoreMethods)

+ (UIImage *) imageWithColor:(UIColor *)color;
+ (UIImage *) scaleImage:(UIImage *)image toSize:(CGSize)newSize;

@end
