//
//  UIImageView+Extensions.swift
//  LordOfTheQuotes
//
//  Created by Matteo Orru on 30/04/25.
//

import Foundation
import UIKit

extension UIView {
    func pinToEdges(of superview: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}


extension UIImageView {
    func addBlurEffect(style: UIBlurEffect.Style = .regular, alpha: CGFloat = 0.8) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = alpha
        
        addSubview(blurEffectView)
    }
}
