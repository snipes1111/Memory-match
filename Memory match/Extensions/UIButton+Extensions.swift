//
//  UIButton+Extension.swift
//  Memory match
//
//  Created by user on 06/05/2024.
//

import UIKit

extension UIButton {
    func configureWith(image: ImageResource) {
        translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(resource: image)
        setImage(image, for: .normal)
    }
    func setSize(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
 }
