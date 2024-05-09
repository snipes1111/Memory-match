//
//  GameViewController+Delegates.swift
//  Memory match
//
//  Created by user on 08/05/2024.
//

import Foundation

extension GameViewController: YouWinViewDelegate {
    func refreshButtonPressed() {
        youWinView.removeFromSuperview()
        viewModel?.refreshButtonDidTapped()
    }
    
    func menuButtonPressed() {
        goBack()
    }
}
