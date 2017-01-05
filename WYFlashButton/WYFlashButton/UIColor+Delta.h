//
//  UIColor+Delta.h
//  WYFlashButton
//
//  Created by wyan assert on 2017/1/5.
//  Copyright © 2017年 wyan assert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Delta)

- (UIColor *)lighterColor;
- (UIColor *)darkerColor;

- (UIColor *)lighterColorWithDelta:(CGFloat)delta;
- (UIColor *)darkerColorWithDelta:(CGFloat)delta;

@end
