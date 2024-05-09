//
//  GameViewController+Extensions.swift
//  Memory match
//
//  Created by user on 07/05/2024.
//

import UIKit
import Combine

//MARK: - Subsriptions
extension GameViewController {
    
    func subscribeToGameInfo() {
        guard let viewModel = viewModel else { return }
        Publishers.CombineLatest(viewModel.$currentTime, viewModel.$moves)
            .sink { [weak self] time, moves in
                self?.timeLabel.text = "TIME: \(time)"
                self?.movesLabel.text = "MOVES: \(String(moves))"
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
    
    func subscribeToWinStatus() {
        viewModel?.$gameIsFinished
            .dropFirst()
            .sink { [weak self] gameIsFinished in
                self?.navigationItem.leftBarButtonItem?.isHidden = true
                self?.addYouWinViewWithAnimation()
            }
            .store(in: &cancellables)
    }
    
    func subscribeToSettings() {
        guard let viewModel = viewModel else { return }
        Publishers.CombineLatest(viewModel.$soundIsOn, viewModel.$vibroIsOn)
            .sink { [weak self] soundIsOn, vibroIsOn in
                self?.settingsView.configureWith(soundIsOn, vibroIsOn)
            }
            .store(in: &cancellables)
    }
}
