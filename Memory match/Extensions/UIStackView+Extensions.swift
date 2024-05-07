//
//  UIStackView+Extensions.swift
//  Memory match
//
//  Created by user on 07/05/2024.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
}
