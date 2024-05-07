//
//  CardCell.swift
//  Memory match
//
//  Created by user on 06/05/2024.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    private lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.configureWith(image: .slot, contentMode: .scaleAspectFit)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        setupCardImageView()
    }
    
    func setupCardImageView() {
        contentView.addSubview(cardImageView)
        cardImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cardImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cardImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        cardImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
