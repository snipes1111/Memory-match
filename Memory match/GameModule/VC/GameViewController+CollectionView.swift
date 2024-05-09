//
//  GameViewController+CollectionView.swift
//  Memory match
//
//  Created by user on 07/05/2024.
//

import UIKit

//MARK: - CollectionView extensions

extension GameViewController {
    enum Section {
        case baseCards
    }
    typealias DataSource = UICollectionViewDiffableDataSource<Section, GameCard>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, GameCard>
    private var cellConfigurationHandler: UICollectionView.CellRegistration<CardCell, GameCard> {
        UICollectionView.CellRegistration { cell, indexPath, item in
            cell.configureWith(gameCard: item) }
    }
    
    func setupCollectionView() {
        dataSource = makeDataSource()
        cardsCollectionView.dataSource = dataSource
        cardsCollectionView.delegate = self
        updateSnapshot()
    }
    
    private func makeDataSource() -> DataSource {
        let configurationHandler = cellConfigurationHandler
        let dataSource = DataSource(collectionView: cardsCollectionView) { collectionView, indexPath, itemIdentifier -> CardCell in
            return collectionView.dequeueConfiguredReusableCell(using: configurationHandler, for: indexPath, item: itemIdentifier)
        }
        return dataSource
    }
    
    private func configureCell(cell: CardCell, indexPath: IndexPath, item: GameCard) {
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

//MARK: - CollectionView Delegate
extension GameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource?.itemIdentifier(for: indexPath) else { return }
        viewModel?.cardDidTapped(item) { [weak self] in
            self?.updateSnapshot()
        }
    }
}

