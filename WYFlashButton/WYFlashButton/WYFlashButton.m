//
//  WYFlashButton.m
//  WYFlashButton
//
//  Created by wyan assert on 2017/1/4.
//  Copyright © 2017年 wyan assert. All rights reserved.
//

#import "WYFlashButton.h"
#import "UIColor+Delta.h"

static CGFloat const DefaultSpeed = 1.0;  //默认速度
static NSUInteger const FramesPerSecond = 60; //动画预期帧数，
static CGFloat const FlashWidth = 0.3;  //默认的抛光宽度，

static CGFloat const IntervalTime = 0.2;  //避免两次动画时间间隔太小导致视觉上的错误

@interface WYFlashButton ()

@property (nonatomic, strong) CAGradientLayer *flashLayer;

@property (nonatomic, strong) UIColor *lighterColor;
@property (nonatomic, strong) UIColor *darkerColor;

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation WYFlashButton

- (instancetype)init {
    if(self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self= [super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

#pragma mark - Public
- (void)startAnimation {
    [self configureView];
}

- (void)stopAnimation {
    [self removeFlash];
    
    [self.displayLink invalidate];
    self.displayLink = nil;
}


#pragma mark - Override
- (void)layoutSubviews {
    [super layoutSubviews];
    self.flashLayer.frame = self.bounds;
}

#pragma mark - Private
- (void)configureView {
    [self.layer addSublayer:self.flashLayer];
    self.flashLayer.frame = self.bounds;
    self.flashLayer.mask = self.titleLabel.layer;
    
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)removeFlash {
    [self.flashLayer removeFromSuperlayer];
}

- (NSArray<UIColor *> *)displayColorArrays {
    return @[(id)self.darkerColor.CGColor, (id)self.darkerColor.CGColor, (id)self.lighterColor.CGColor, (id)self.darkerColor.CGColor, (id)self.darkerColor.CGColor];
}


#pragma mark - ACtion
- (void)updateTitleColorArray {
    static CGFloat centerLocation = 0;
    
    centerLocation += self.speed / FramesPerSecond;
    if(centerLocation >= 1 + self.flashWidth / 2 + IntervalTime) {
        centerLocation = -self.flashWidth / 2 - IntervalTime;
    }
    
    self.flashLayer.locations = @[@(0), @(MAX(0, centerLocation - self.flashWidth / 2)), @(centerLocation < 0 ? 0 : (centerLocation > 1 ? 1 : centerLocation)), @(MIN(1, centerLocation + self.flashWidth / 2)), @1];
    self.flashLayer.colors = [self displayColorArrays];
    
}


#pragma mark - Getter
- (CAGradientLayer *)flashLayer {
    if(!_flashLayer) {
        _flashLayer = [CAGradientLayer layer];
        
        _flashLayer.colors = [self displayColorArrays];
        _flashLayer.startPoint = CGPointMake(0, 0);
        _flashLayer.endPoint = CGPointMake(1, 0);
        _flashLayer.locations = @[@(0), @0.0, @(0.0), @(0.1), @1];
    }
    return _flashLayer;
}

- (UIColor *)lighterColor {
    return [self.currentTitleColor lighterColorWithDelta:0.5];
}

- (UIColor *)darkerColor {
    return [self.currentTitleColor darkerColor];
}

- (CGFloat)speed {
    if(!_speed) {
        return DefaultSpeed;
    } else {
        return _speed;
    }
}

- (CGFloat)flashWidth {
    if(!_flashWidth) {
        return FlashWidth;
    } else {
        return _flashWidth;
    }
}

- (CADisplayLink *)displayLink {
    if(!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTitleColorArray)];
        if(([[[UIDevice currentDevice] systemVersion] compare:@"10.0" options:NSNumericSearch] != NSOrderedAscending)) {
            _displayLink.preferredFramesPerSecond = FramesPerSecond;
        } else {
            _displayLink.frameInterval = (ceil(60.0 / FramesPerSecond));
        }
    }
    return _displayLink;
}

@end
