//
//  GameViewController+Extensions.swift
//  Memory match
//
//  Created by user on 07/05/2024.
//

import UIKit


//MARK: - CollectionView extensions
extension GameViewController {
    func setupCollectionView() {
        dataSource = makeDataSource()
        cardsCollectionView.dataSource = dataSource
        cardsCollectionView.delegate = self
        updateSnapshot()
    }
}

extension GameViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource?.itemIdentifier(for: indexPath) else { return }
        viewModel?.cardDidTapped(item) { [weak self] in
            self?.updateSnapshot()
        }
    }
}

//MARK: - Subsriptions

extension GameViewController {
    func subscribeToTimer() {
        viewModel?.$currentTime
            .sink { [weak self] time in
                self?.timeLabel.text = "TIME: \(time)"
            }
            .store(in: &cancellables)
    }
    
    func subscribeToGameActiveStatus() {
        viewModel?.$gameIsStopped
            .sink { [weak self] isStopped in
                self?.cardsCollectionView.isUserInteractionEnabled = !isStopped
                let image = UIImage(resource: isStopped ? .play : .pause)
                self?.pauseButton.setImage(image, for: .normal)
            }
            .store(in: &cancellables)
    }
    
    func subscribeToMoves() {
        viewModel?.$moves
            .sink { [weak self] num in
                self?.movesLabel.text = "MOVES: \(String(num))"
            }
            .store(in: &cancellables)
    }
    
    func subscribeToWinStatus() {
        viewModel?.$gameIsFinished
            .dropFirst()
            .sink { [weak self] gameIsFinished in
                self?.navigationItem.leftBarButtonItem?.isHidden = true
                self?.addYouWinViewWithAnimation()
            }
            .store(in: &cancellables)
    }
    
}
