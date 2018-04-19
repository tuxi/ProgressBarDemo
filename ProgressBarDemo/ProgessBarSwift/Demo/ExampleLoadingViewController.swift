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
        self.view.backgroundColor = UIColor.black
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
    }
    
    @objc fileprivate func toggleLoading(sender: UIButton) {
        if sender.tag == ExampleLoadingViewController.BaseTag {
            progressView.startLoading()
        }
        else {
            progressView.endLoading()
        }
    }

}
