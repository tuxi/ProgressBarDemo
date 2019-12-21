//
// GradientProgressView.swift
// ProgressBarDemo
//
// Created by xiaoyuan on 2019/12/21.
// Copyright © 2019 Ossey. All rights reserved.
//

import UIKit

class GradientProgressView: OSProgressView {

    class ProgressBar: UIImageView  {
        override class var layerClass: AnyClass {
            return CAGradientLayer.self
        }
    }
    
    override var progressBarClass: UIImageView.Type {
        return ProgressBar.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        self.trackTintColor = UIColor(red: 230 / 255.0, green: 230 / 255.0, blue: 230 / 255.0, alpha: 1.0)
        self.layer.cornerRadius = 2
        self.layer.masksToBounds = true
    
        if let gradientLayer = self.progressBar.layer as? CAGradientLayer {
            gradientLayer.cornerRadius = 1.9921874999999998
            gradientLayer.colors = [
                UIColor(red: 204.0 / 255.0, green: 234.0 / 255.0, blue: 75.0 / 255.0, alpha: 1.0).cgColor,
                UIColor(red: 239.0 / 255.0, green: 126.0 / 255.0, blue: 49.0 / 255.0, alpha: 1.0).cgColor]
            gradientLayer.locations = [0, 0.7]
            gradientLayer.startPoint = CGPoint(x: 0, y: 1)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        }
    }

}
