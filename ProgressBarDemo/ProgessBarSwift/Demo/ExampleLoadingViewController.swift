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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.backgroundImage(for: .compact)
        self.view.backgroundColor = UIColor.black
        navigationController!.progressView.progressHeight = 0.5
        navigationController!.progressView.trackTintColor = UIColor.white
        navigationController!.progressView.progressTintColor = UIColor.blue
        
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
        navigationController?.progressView.cancellationHandler = {
            print("cancellationHandler")
        }
        
        navigationController?.progressView.completionHandler = {
            print("completionHandler")
        }
        
        navigationController?.progressView.progressHandler = { (progress: CGFloat) in
            print(progress)
        }
        
    }
    
    @objc fileprivate func startLoading() {
        
    }

}
