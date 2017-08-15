//
//  UINavigationController+OSProgressBar.swift
//  ProgressBarDemo
//
//  Created by Ossey on 15/08/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

import UIKit

public extension UINavigationController {
    
    public var progressHeight: CGFloat {
        get {
            return progressView.frame.height
        }
        set {
            progressView.frame.origin.y = navigationBar.frame.height - newValue
            progressView.frame.size.height = newValue
        }
    }
    
    public var trackTintColor: UIColor? {
        get {
            return progressView.trackTintColor
        }
        set {
            progressView.trackTintColor = newValue
        }
    }
    
    public var progressTintColor: UIColor? {
        get {
            return progressView.progressTintColor
        }
        set {
            progressView.progressTintColor = newValue
        }
    }
    
    public var progress : CGFloat {
        get {
         return progressView.progress
        }
        set {
            progressView.progress = newValue
        }
    }
    
    private var progressView: OSProgressView {
        for subview in navigationBar.subviews {
            if let progressView = subview as? OSProgressView {
                return progressView
            }
        }
        
        let defaultHeight = CGFloat(2.0)
        
        let frame = CGRect(x: 0, y: navigationBar.frame.height - defaultHeight, width: navigationBar.frame.width, height: defaultHeight)
        
        let progressView = OSProgressView(frame: frame)
        
        navigationBar.addSubview(progressView)
        
        progressView.autoresizingMask = [
            .flexibleWidth, .flexibleTopMargin
        ]
        
        return progressView
    }
   
    public func setProgress(progress: CGFloat, animated: Bool) {
        progressView.bar.alpha = 1.0
        progressView.setProgress(progress: progress, animate: animated)
    }
    
    public func finishProgress() {
        progressView.bar.alpha = 1.0
        progressView.setProgress(progress: 1.0, animate: true)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.progressView.bar.alpha = 0.0
        }) { (finished: Bool) in
            self.progressView.progress = 0.0
        }
    }
    
    public func cancelProgress() {
        progressView.setProgress(progress: 0.0, animate: true)
        
        UIView.animate(withDuration: 0.25) { 
            self.progressView.alpha = 0.0
        }
    }
}
