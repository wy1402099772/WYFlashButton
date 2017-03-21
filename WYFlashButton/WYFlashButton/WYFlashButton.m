//
//  WYFlashButton.m
//  WYFlashButton
//
//  Created by wyan assert on 2017/1/4.
//  Copyright © 2017年 wyan assert. All rights reserved.
//

#import "WYFlashButton.h"
#import "UIColor+Delta.h"

#define kFloor0AndCeil1(x) (x) < 0 ? 0 : ((x) > 1 ? 1 : (x))

static CGFloat const DefaultSpeed = 1.0;  //默认速度
static NSUInteger const FramesPerSecond = 60; //动画预期帧数，
static CGFloat const FlashWidth = 0.3;  //默认的抛光宽度，

static CGFloat const IntervalTime = 0.2;  //避免两次动画时间间隔太小导致视觉上的错误

@interface WYFlashButton ()

@property (nonatomic, strong) CAGradientLayer *flashLayer;

@property (nonatomic, strong) UIColor *lighterColor;
@property (nonatomic, strong) UIColor *darkerColor;

@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, assign) CGFloat centerLocation;

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


#pragma mark - Override
- (void)layoutSubviews {    
    if(self.flashLayer.superlayer && self.flashLayer.mask) {
        [super layoutSubviews];
        self.flashLayer.frame = self.bounds;
    }
}

- (void)dealloc {
    [self stopAnimation];
}

#pragma mark - Public
- (void)startAnimation {
    [self configureView];
}

- (void)stopAnimation {
    self.flashLayer.mask = nil;
    [self removeFlash];
    
    [self.displayLink invalidate];
//    self.displayLink = nil;
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
    
    self.centerLocation += self.speed / self.framesPerSecond;
    if(self.centerLocation >= 1 + self.intervalTime) {
        self.centerLocation = - self.intervalTime;
    }
    
    self.flashLayer.locations = @[@(0), @(kFloor0AndCeil1(self.centerLocation - self.flashWidth / 2)), @(kFloor0AndCeil1(self.centerLocation)), @(kFloor0AndCeil1(self.centerLocation + self.flashWidth / 2)), @1];
    self.flashLayer.colors = [self displayColorArrays];
    
    
//    NSLog(@"%f,  %@", centerLocation, self.flashLayer.locations);
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
    return [self.currentTitleColor lighterColorWithDelta:0.4];
}

- (UIColor *)darkerColor {
    return [self.currentTitleColor darkerColorWithDelta:0.05];
}

- (CADisplayLink *)displayLink {
    if(!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTitleColorArray)];
        if(([[[UIDevice currentDevice] systemVersion] compare:@"10.0" options:NSNumericSearch] != NSOrderedAscending)) {
            _displayLink.preferredFramesPerSecond = self.framesPerSecond;
        } else {
            _displayLink.frameInterval = (ceil(60.0 / self.framesPerSecond));
        }
    }
    return _displayLink;
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

- (NSInteger)framesPerSecond {
    if(!_framesPerSecond) {
        return FramesPerSecond;
    } else {
        return _framesPerSecond;
    }
}

- (CGFloat)intervalTime {
    if(!_intervalTime) {
        return IntervalTime * self.speed;
    } else {
        return _intervalTime * self.speed;
    }
}

@end
