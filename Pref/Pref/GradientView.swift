//
//  GradientView.swift
//  Pref
//
//  Created by  Mikhail on 15.07.2020.
//  Copyright © 2020  Mikhail. All rights reserved.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    @IBInspectable private var startColor: UIColor?
    @IBInspectable private var endColor: UIColor?
    
    let firstColor = #colorLiteral(red: 0.1921568627, green: 0.3254901961, blue: 0.4235294118, alpha: 1)
    let secondColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    private var gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        for view in self.subviews {
            self.bringSubviewToFront(view)
        }

    }
    
    
    
    private func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
    }
    
}
