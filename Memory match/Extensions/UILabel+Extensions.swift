//
//  UILabel+Extension.swift
//  Memory match
//
//  Created by user on 06/05/2024.
//

import UIKit

extension UILabel {
    func configureWith(text: String, font: UIFont) {
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontForContentSizeCategory = true
        self.font = font
        textColor = .white
        self.text = text
        textAlignment = .center
    }
}
