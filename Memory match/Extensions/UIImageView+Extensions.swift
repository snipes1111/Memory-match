//
//  UIImageView+Extensions.swift
//  Memory match
//
//  Created by user on 06/05/2024.
//

import UIKit

extension UIImageView {
    func configureWith(image: ImageResource, contentMode: ContentMode) {
        translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = contentMode
        self.image = UIImage(resource: image)
    }
}
