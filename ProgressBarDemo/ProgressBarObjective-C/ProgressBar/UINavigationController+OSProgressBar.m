//
//  UINavigationController+OSProgressBar.m
//  ProgressBarDemo
//
//  Created by Ossey on 15/08/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

#import "UINavigationController+OSProgressBar.h"
#import "OSProgressView.h"

@interface UINavigationController ()

@property (nonatomic, weak) OSProgressView *progressView;

@end

@implementation UINavigationController (OSProgressBar)

- (OSProgressView *)progressView {
    
    NSUInteger foundIndex = [self.navigationBar.subviews indexOfObjectPassingTest:^BOOL(__kindof UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL res = [subview isKindOfClass:[OSProgressView class]];
        if (res) {
            *stop = YES;
        }
        return res;
    }];
    
    if (foundIndex != NSNotFound) {
        return self.navigationBar.subviews[foundIndex];
    }
    
    CGFloat defaultHeight = 2.0;
    CGRect frame = CGRectMake(0,
                              self.navigationBar.frame.size.height - defaultHeight,
                              self.navigationBar.frame.size.width,
                              defaultHeight);
    OSProgressView *progressView = [[OSProgressView alloc] initWithFrame:frame];
    [self.navigationBar addSubview:progressView];
    progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    return progressView;
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    self.progressView.progressBar.alpha = 1.0;
    [self.progressView setProgress:progress animated:animated];
}

- (void)setProgressTintColor:(UIColor *)progressTintColor {
    self.progressView.progressTintColor = progressTintColor;
}

- (void)setProgressTrackTintColor:(UIColor *)progressTrackTintColor {
    self.progressView.trackTintColor = progressTrackTintColor;
}

- (UIColor *)progressTrackTintColor {
    return self.progressView.trackTintColor;
}

- (UIColor *)progressTintColor {
    return self.progressView.progressTintColor;
}

- (void)setProgress:(CGFloat)progress {
    self.progressView.progress = progress;
}

- (CGFloat)progress {
    return self.progressView.progress;
}

- (void)setProgressHeight:(CGFloat)progressHeight {
    CGRect rect = self.progressView.frame;
    rect.origin.y = self.navigationBar.frame.size.height - progressHeight;
    rect.size.height = progressHeight;
    self.progressView.frame = rect;
}

- (CGFloat)progressHeight {
    return self.progressView.frame.size.height;
}

- (void)finishProgress {

    [self setProgress:1.0 animated:YES];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.progressView.progressBar.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.progress = 0.0;
    }];
}

- (void)cancelProgress {
    
    [self.progressView setProgress:0.0 animated:YES];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.progressView.progressBar.alpha = 0.0;
    }];
}

@end
