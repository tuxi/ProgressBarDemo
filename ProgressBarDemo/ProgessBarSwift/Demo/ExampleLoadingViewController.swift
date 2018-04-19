//
//  ExampleLoadingViewController.swift
//  ProgessBarSwift
//
//  Created by swae on 2018/4/18.
//  Copyright © 2018年 Ossey. All rights reserved.
//

import UIKit

class ExampleLoadingViewController: UIViewController {

    private var timer: Timer?
    
    public lazy var progressView: OSProgressView = {
        
        let defaultHeight = CGFloat(0.5)
        
        let frame = CGRect(x: 0,
                           y: 100,
                           width: 200.0,
                           height: defaultHeight)
        
        let progressView = OSProgressView(frame: frame)
        progressView.autoresizingMask = [
            .flexibleWidth, .flexibleTopMargin
        ]
        
        return progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(progressView)
        progressView.trackTintColor = UIColor.black
        progressView.progressTintColor = UIColor.white
        var i: NSInteger = 0
        let btnTitleArray = ["start loading", "end loading"]
        let centerYConstantArray = [NSNumber.init(value: -50.0), NSNumber.init(value: 0.0), NSNumber.init(value: 50.0), NSNumber.init(value: 100)]
        
        while i < btnTitleArray.count {
            let btn: UIButton = UIButton(type: .system)
            btn.translatesAutoresizingMaskIntoConstraints = false
            let centerX = NSLayoutConstraint(item: btn,
                                             attribute: .centerX,
                                             relatedBy: .equal,
                                             toItem: view,
                                             attribute: .centerX,
                                             multiplier: 1.0,
                                             constant: 0.0)
            let centerY = NSLayoutConstraint(item: btn,
                                             attribute: .centerY,
                                             relatedBy: .equal,
                                             toItem: view,
                                             attribute: .centerY,
                                             multiplier: 1.0,
                                             constant: CGFloat(centerYConstantArray[i].floatValue))
            btn.setTitle(btnTitleArray[i], for: .normal)
            btn.addTarget(self, action: #selector(ExampleLoadingViewController.startLoading), for: .touchUpInside)
            view.addSubview(btn)
            btn.tag = i + 100
            view.addConstraints([centerX, centerY])
            i += 1
        }
        
        /**
         call back for progress
         */
        progressView.cancellationHandler = {
            print("cancellationHandler")
        }
        
        progressView.completionHandler = {
            print("completionHandler")
        }
        
        progressView.progressHandler = { (progress: CGFloat) in
            print(progress)
        }
        
        
        
    }
    

    private func invalidateTimer() {
        if timer == nil {
            return
        }
        timer?.invalidate()
        timer = nil
    }
    
    deinit {
        invalidateTimer()
    }
    
    @objc fileprivate func loading() {
        progressView.completed()
    }
    
    @objc fileprivate func startLoading() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(loading), userInfo: nil, repeats: true)
            return;
        }
    }

}
