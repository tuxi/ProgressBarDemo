//
//  ViewController.m
//  ProgressBarObjective-C
//
//  Created by Ossey on 15/08/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationController+OSProgressBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSInteger i = 0;
    CGFloat centerYConstant = 0.0;
    NSArray *btnTitleArray = @[@"update progress", @"finish progress", @"cancel progress"];
    do {
        __unused UIButton *updateProgressBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            
            NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
            NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:centerYConstant];
            [btn setTitle:btnTitleArray[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(updateProgressValue:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
            [self.view addConstraints:@[centerX, centerY]];
            btn.tag = i+100;
            centerYConstant += 30;
            btn;
        });
        i++;
    } while (i < 3);
    
    

    
    self.navigationController.progressHeight = 2.0;
    self.navigationController.progressTintColor = [UIColor greenColor];
    self.navigationController.progressTrackTintColor = [UIColor clearColor];
}

- (void)updateProgressValue:(UIButton *)btn {
    NSInteger idx = btn.tag - 100;
    if (idx == 0) {
        CGFloat progress = self.navigationController.progress;
        [self.navigationController setProgress:progress+0.1 animated:YES];
    }
    else if (idx == 1) {
        [self.navigationController finishProgress];
    }
    else if (idx == 2) {
        [self.navigationController cancelProgress];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
