//
//  GameViewController+CollectionView.swift
//  Memory match
//
//  Created by user on 07/05/2024.
//

import UIKit

extension GameViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Int>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Int>
    
    enum Section {
        case baseCards
    }
    
    func makeDataSource() -> DataSource {
        let configurationHandler = cellConfigurationHandler
        let dataSource = DataSource(collectionView: cardsCollectionView) { collectionView, indexPath, itemIdentifier -> CardCell in
            return collectionView.dequeueConfiguredReusableCell(using: configurationHandler, for: indexPath, item: itemIdentifier)
        }
        return dataSource
    }
    
    func configureCell(cell: CardCell, indexPath: IndexPath, item: Int) {
        
    }
    
    func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.baseCards])
        snapshot.appendItems(data, toSection: .baseCards)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
