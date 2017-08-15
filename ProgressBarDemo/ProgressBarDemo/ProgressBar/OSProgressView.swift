//
//  OSProgressView.swift
//  ProgressBarDemo
//
//  Created by Ossey on 15/08/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

import UIKit

public final class OSProgressView: UIView {

    internal var progress: CGFloat = 0 {
        didSet {
            progress = min(1, progress)
            barWidthConstraint.constant = bounds.width * CGFloat(progress)
        }
    }
    
    internal let bar = UIView()
    
    fileprivate let barWidthConstraint : NSLayoutConstraint
    
    public dynamic var trackTintColor : UIColor? = .clear {
        didSet {
            backgroundColor = trackTintColor;
        }
    }
    
    public dynamic var progressTintColor : UIColor? = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1) {
        didSet {
            bar.backgroundColor = progressTintColor
        }
    }
    
    public override var frame: CGRect {
        didSet {
            let tempProgress = progress
            progress = tempProgress
        }
    }

    /* ====================================================================== */
    // MARK: - initializer
    /* ====================================================================== */
    public override init(frame: CGRect) {
        
        barWidthConstraint = NSLayoutConstraint(item: bar, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: frame.width * CGFloat(progress))
        
        super.init(frame: frame);
        
        let leftConstraint = NSLayoutConstraint(item: bar, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0.0)
        
        let bottomConstraint = NSLayoutConstraint(item: bar, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        let topConstraint = NSLayoutConstraint(item: bar, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        
        addSubview(bar)
        
        bar.backgroundColor = trackTintColor
        
        bar.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints([
            barWidthConstraint,
            leftConstraint,
            bottomConstraint,
            topConstraint
            ])
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setProgress(progress: CGFloat, animate: Bool) {
        
        let duration : TimeInterval = animate ? 0.1 : 0.0
        
        self.progress = progress
        
        UIView.animate(withDuration: duration) { 
            self.layoutIfNeeded()
        }
    }
}
