//
//  ExampleLoadingViewController.swift
//  ProgessBarSwift
//
//  Created by swae on 2018/4/18.
//  Copyright © 2018年 Ossey. All rights reserved.
//

import UIKit

class ExampleLoadingViewController: UIViewController {
    static let BaseTag: Int = 100
    private var timer: Timer?
    public lazy var progressView: GradientProgressView = {
        
        let progressView = GradientProgressView(frame: .zero)
        progressView.autoresizingMask = [
            .flexibleWidth, .flexibleTopMargin
        ]
        
        return progressView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|[progressView]|", options: [], metrics: nil, views: ["progressView": progressView]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[progressView(==0.5)]-(49.0)-|", options: [], metrics: nil, views: ["progressView": progressView]))
        progressView.trackTintColor = UIColor.lightGray.withAlphaComponent(0.6)
        progressView.loadingTintColor = UIColor.white
        progressView.progressTintColor = UIColor.white
        var i: NSInteger = 0
        let btnTitleArray = ["start loading", "end loading", "auto update progress", "auto completion"]
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
            btn.addTarget(self, action: #selector(ExampleLoadingViewController.toggleLoading), for: .touchUpInside)
            view.addSubview(btn)
            btn.tag = i + ExampleLoadingViewController.BaseTag
            view.addConstraints([centerX, centerY])
            i += 1
        }
        
        progressView.progressHandler = { (progress: CGFloat) in
            print(progress)
        }
    
    }
    
    deinit {
        progressView.endLoading()
        invalidateTimer()
    }
    
    @objc fileprivate func toggleLoading(sender: UIButton) {
        if sender.tag == ExampleLoadingViewController.BaseTag {
            invalidateTimer()
            progressView.startLoading()
        }
        else if sender.tag == ExampleLoadingViewController.BaseTag + 1 {
            progressView.endLoading()
        } else if sender.tag == ExampleLoadingViewController.BaseTag + 2 {
            startLoading(tag: sender.tag)
        } else if sender.tag == ExampleLoadingViewController.BaseTag + 3 {
            autoCompletion()
        }
    }
    
    @objc private func autoUpdateProgress() {
        
        var progress = progressView.progress
        if progress >= 1 {
            progress = 0.0
        }
        progress += 0.05
        progressView.setProgress(progress: CGFloat(progress), animated: true)
        if progress >= 1.0 {
            invalidateTimer()
        }
    }
    
    @objc private func autoCompletion() {
        invalidateTimer()
        progressView.startLoading()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+5.0) {
            self.startLoading(tag: ExampleLoadingViewController.BaseTag + 2)
        }
    }
    
    private func startLoading(tag: Int) {
        invalidateTimer()
        if tag == ExampleLoadingViewController.BaseTag + 2 {
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(autoUpdateProgress), userInfo: nil, repeats: true)
        }
        else if tag == ExampleLoadingViewController.BaseTag + 3 {
            autoCompletion()
        }
        
    }
    
    private func invalidateTimer() {
        if timer == nil {
            return
        }
        timer?.invalidate()
        timer = nil
    }

}
