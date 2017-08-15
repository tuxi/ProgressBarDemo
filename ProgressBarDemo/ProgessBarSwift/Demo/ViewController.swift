//
//  ViewController.swift
//  ProgressBarDemo
//
//  Created by Ossey on 15/08/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.progressView.progressHeight = 2
        navigationController!.progressView.trackTintColor = UIColor.clear
        navigationController!.progressView.progressTintColor = UIColor.blue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func updateProgress(_ sender: Any) {
        
        let progress = navigationController!.progressView.progress
        
        navigationController!.progressView.setProgress(progress: CGFloat(progress+0.1), animated: true)
    }

}

