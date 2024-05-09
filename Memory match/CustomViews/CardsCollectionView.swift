//
//  CardsCollectionView.swift
//  Memory match
//
//  Created by user on 07/05/2024.
//

import UIKit

final class CardsCollectionView: UICollectionView {
    init(superViewWidth: CGFloat, itemSpacing: CGFloat = 8, sideInsets: CGFloat = 16, itemsPerRow: CGFloat) {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        configureLayout(superViewWidth: superViewWidth, itemSpacing: itemSpacing,
                        sideInsets: sideInsets, itemsPerRow: itemsPerRow)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        isScrollEnabled = false
    }
    
    private func configureLayout(superViewWidth: CGFloat, itemSpacing: CGFloat,
                              sideInsets: CGFloat, itemsPerRow: CGFloat) {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = itemSpacing
        let itemWidth: CGFloat = calculateItemWidth(superViewWidth: superViewWidth, itemSpacing: itemSpacing,
                                                    sideInsets: sideInsets, itemsPerRow: itemsPerRow)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
    
    private func calculateItemWidth(superViewWidth: CGFloat, itemSpacing: CGFloat,
                                    sideInsets: CGFloat, itemsPerRow: CGFloat) -> CGFloat {
        let sideSpacing = sideInsets * 2
        let interItemSpacing = itemSpacing * (itemsPerRow - 1)
        let freeSpacing = superViewWidth - sideSpacing - interItemSpacing
        return freeSpacing / itemsPerRow
    }
}
