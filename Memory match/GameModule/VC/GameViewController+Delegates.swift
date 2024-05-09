//
//  GameViewController+Delegates.swift
//  Memory match
//
//  Created by user on 08/05/2024.
//

import Foundation

// YouWinScreen Delegate
extension GameViewController: YouWinViewDelegate {
    func refreshButtonPressed() {
        youWinView.removeFromSuperview()
        viewModel?.refreshButtonDidTapped()
        updateSnapshot()
    }
    
    func menuButtonPressed() {
        goToMainMenu()
    }
}

// SettingsView Delegate
extension GameViewController: SettingsViewDelegate {
    func resumeGame() {
        showSettings()
    }
    
    func returnToMainMenu() {
        goToMainMenu()
    }
    
    func switchSound() {
        viewModel?.switchSound()
    }
    
    func switchVibro() {
        viewModel?.switchVibro()
    }
}
