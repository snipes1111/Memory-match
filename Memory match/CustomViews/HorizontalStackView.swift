//
//  HorizontalStackView.swift
//  Memory match
//
//  Created by user on 07/05/2024.
//

import UIKit

final class HorizontalStackView: UIStackView {
    init(_ views: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        addArrangedSubviews(views)
        self.spacing = spacing
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
