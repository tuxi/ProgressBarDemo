//
//  UINavigationController+OSProgressBar.h
//  ProgressBarDemo
//
//  Created by Ossey on 15/08/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (OSProgressBar)

@property (nonatomic, strong) UIColor *progressTintColor;

@property (nonatomic, strong) UIColor *progressTrackTintColor;

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, assign) CGFloat progressHeight;

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

- (void)finishProgress;

- (void)cancelProgress;

@end
