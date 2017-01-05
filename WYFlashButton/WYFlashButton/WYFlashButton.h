//
//  WYFlashButton.h
//  WYFlashButton
//
//  Created by wyan assert on 2017/1/4.
//  Copyright © 2017年 wyan assert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYFlashButton : UIButton

@property (nonatomic, assign) CGFloat speed;  //默认 1.0  建议0.3~3
@property (nonatomic, assign) CGFloat flashWidth; //抛光的宽度， 默认是0.3

- (void)startAnimation;
- (void)stopAnimation;

@end
