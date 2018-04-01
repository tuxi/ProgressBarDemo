//
//  ViewController.m
//  ProgressBarObjective-C
//
//  Created by alpface on 15/08/2017.
//  Copyright © 2017 alpface. All rights reserved.
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
    NSArray *centerYConstantArray = @[@-50.0, @0.0, @50.0];
    NSArray *btnTitleArray = @[@"update progress", @"finish progress", @"cancel progress"];
    do {
        __unused UIButton *updateProgressBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            
            NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:btn
                                                                       attribute:NSLayoutAttributeCenterX
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeCenterX
                                                                      multiplier:1.0
                                                                        constant:0.0];
            NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:btn
                                                                       attribute:NSLayoutAttributeCenterY
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeCenterY
                                                                      multiplier:1.0
                                                                        constant:[centerYConstantArray[i] floatValue]];
            [btn setTitle:btnTitleArray[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(updateProgressValue:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
            [self.view addConstraints:@[centerX, centerY]];
            btn.tag = i+100;
            btn;
        });
        i++;
    } while (i < 3);
    
    

    
    self.navigationController.progressView.progressHeight = 2.0;
    self.navigationController.progressView.progressTintColor = [UIColor redColor];
    self.navigationController.progressView.trackTintColor = [UIColor clearColor];
    
}

- (void)updateProgressValue:(UIButton *)btn {
    NSInteger idx = btn.tag - 100;
    switch (idx) {
        case 0: {
            CGFloat progress = self.navigationController.progressView.progress;
            [self.navigationController.progressView setProgress:progress+0.1 animated:YES];
        } break;
        case 1: {
            [self.navigationController.progressView finishProgress];
        } break;
        case 2: {
            [self.navigationController.progressView cancelProgress];
            
        } break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
