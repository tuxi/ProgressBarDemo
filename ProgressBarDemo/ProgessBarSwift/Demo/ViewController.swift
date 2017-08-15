//
//  ViewController.swift
//  ProgressBarDemo
//
//  Created by Ossey on 15/08/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var timer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.progressView.progressHeight = 2
        navigationController!.progressView.trackTintColor = UIColor.clear
        navigationController!.progressView.progressTintColor = UIColor.blue
        
        var i: NSInteger = 0
        let btnTitleArray = ["update progress", "finish progress", "cancel progress", "auto update progress"]
        let centerYConstantArray = [NSNumber.init(value: -50.0), NSNumber.init(value: 0.0), NSNumber.init(value: 50.0), NSNumber.init(value: 100)]
        
        while i < 4 {
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
            btn.addTarget(self, action: #selector(ViewController.updateProgress(_:)), for: .touchUpInside)
            view.addSubview(btn)
            btn.tag = i + 100
            view.addConstraints([centerX, centerY])
            i += 1
        }
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc private func updateProgress(_ sender: UIButton) {
        
        let idx = sender.tag - 100
        
        switch idx {
        case 0:
            let progress = navigationController!.progressView.progress
            navigationController!.progressView.setProgress(progress: CGFloat(progress+0.1), animated: true)
         break
        case 1:
            navigationController!.progressView.completed()
            invalidateTimer()
            break
        case 2:
            navigationController!.progressView.cancel()
            invalidateTimer()
            break
        default:
            autoUpdateProgress()
         break
            
        }
        
    }

    @objc private func autoUpdateProgress() {
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(autoUpdateProgress), userInfo: nil, repeats: true)
            return;
        }
        
        var progress = navigationController!.progressView.progress
        if progress >= 1 {
            progress = 0.0
        }
        progress += 0.05
        navigationController!.progressView.setProgress(progress: CGFloat(progress), animated: true)
        if progress >= 1.0 {
            invalidateTimer()
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
    
}

