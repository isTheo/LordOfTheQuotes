//
//  UIView+Extensions.swift
//  LordOfTheQuotes
//
//  Created by Matteo Orru on 30/04/25.
//

import Foundation
import UIKit



extension UIFont {
    static func lordOfTheRings(size: CGFloat) -> UIFont {
        if let customFont = UIFont(name: "MiddleEarthPERSONALUSE-Regular", size: size) {
            return customFont
        } else {
            print("custom font not found, back to the system font")
            return UIFont.systemFont(ofSize: size, weight: .bold)
        }
    }
}
