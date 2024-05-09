//
//  GameViewController+CollectionView.swift
//  Memory match
//
//  Created by user on 07/05/2024.
//

import UIKit

extension GameViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, GameCard>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, GameCard>
    
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
    
    func configureCell(cell: CardCell, indexPath: IndexPath, item: GameCard) {
        cell.configureWith(gameCard: item)
    }
    
    func updateSnapshot() {
        guard let viewModel = viewModel else { return }
        var snapshot = Snapshot()
        snapshot.appendSections([.baseCards])
        snapshot.appendItems(viewModel.gameCards, toSection: .baseCards)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
