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
@property (nonatomic, assign) NSInteger framesPerSecond;  //默认60
@property (nonatomic, assign) CGFloat intervalTime; //速度较快时  会产生抛光回走的问题， 适当增大这个值， 默认0.2 设置为0时会使用默认值

- (void)startAnimation;
- (void)stopAnimation;

@end
