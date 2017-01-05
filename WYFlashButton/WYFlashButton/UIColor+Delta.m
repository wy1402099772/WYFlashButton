//
//  UIColor+Delta.m
//  WYFlashButton
//
//  Created by wyan assert on 2017/1/5.
//  Copyright © 2017年 wyan assert. All rights reserved.
//

#import "UIColor+Delta.h"

@implementation UIColor (Delta)

- (UIColor *)lighterColor {
    CGFloat r, g, b, a;
    if([self getRed:&r green:&g blue:&b alpha:&a]) {
        return [UIColor colorWithRed:MIN(r + 0.1, 1.0)
                               green:MIN(g + 0.1, 1.0)
                                blue:MIN(b + 0.1, 1.0)
                               alpha:a];
    } else {
        return self;
    }
}

- (UIColor *)darkerColor {
    CGFloat r, g, b, a;
    if ([self getRed:&r green:&g blue:&b alpha:&a]) {
        return [UIColor colorWithRed:MAX(r - 0.1, 0.0)
                               green:MAX(g - 0.1, 0.0)
                                blue:MAX(b - 0.1, 0.0)
                               alpha:a];
    } else {
        return self;
    }
}

- (UIColor *)lighterColorWithDelta:(CGFloat)delta {
    CGFloat r, g, b, a;
    if([self getRed:&r green:&g blue:&b alpha:&a]) {
        return [UIColor colorWithRed:MIN(r + delta, 1.0)
                               green:MIN(g + delta, 1.0)
                                blue:MIN(b + delta, 1.0)
                               alpha:a];
    } else {
        return self;
    }
}

- (UIColor *)darkerColorWithDelta:(CGFloat)delta {
    CGFloat r, g, b, a;
    if ([self getRed:&r green:&g blue:&b alpha:&a]) {
        return [UIColor colorWithRed:MAX(r - delta, 0.0)
                               green:MAX(g - delta, 0.0)
                                blue:MAX(b - delta, 0.0)
                               alpha:a];
    } else {
        return self;
    }
}

@end
