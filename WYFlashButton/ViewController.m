//
//  ViewController.m
//  WYFlashButton
//
//  Created by wyan assert on 2017/1/4.
//  Copyright © 2017年 wyan assert. All rights reserved.
//

#import "ViewController.h"
#import "WYFlashButton.h"

@interface ViewController () {
    CAGradientLayer *gradientLayer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WYFlashButton *button = [[WYFlashButton alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    [button setTitle:@"jnkxjaahckajcbkjxabxn" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    button.framesPerSecond = 30;
    button.speed = 5;
    button.intervalTime = 0.1;
    [button startAnimation];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
