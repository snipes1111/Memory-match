//
//  GameViewController+Constraints.swift
//  Memory match
//
//  Created by user on 09/05/2024.
//

import UIKit

extension GameViewController {
// MARK: Setup Views
        func addSubviews() {
            view.addSubview(backgroundImageView)
            view.addSubview(gameInfoImageView)
            gameInfoImageView.addSubview(gameInfoStackView)
            view.addSubview(cardsCollectionView)
            view.addSubview(controlButtonsStackView)
            view.addSubview(settingsView)
        }
        
        func makeConstraints() {
            // Setup backgroundImageView constraints
            backgroundImageView.fillSuperView(view)
            // Setup gameInfoImageView constraints
            gameInfoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
            gameInfoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
            gameInfoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
            gameInfoImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            // Setup settingsButton constraints
            settingsButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
            // Setup gameInfoStackView constraints
            gameInfoStackView.leadingAnchor.constraint(equalTo: gameInfoImageView.leadingAnchor, constant: 32).isActive = true
            gameInfoStackView.trailingAnchor.constraint(equalTo: gameInfoImageView.trailingAnchor, constant: -32).isActive = true
            gameInfoStackView.topAnchor.constraint(equalTo: gameInfoImageView.topAnchor, constant: 16).isActive = true
            gameInfoStackView.bottomAnchor.constraint(equalTo: gameInfoImageView.bottomAnchor, constant: -16).isActive = true
            // Setup cardsCollectionView constraints
            cardsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
            cardsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
            cardsCollectionView.topAnchor.constraint(equalTo: gameInfoImageView.bottomAnchor, constant: 24).isActive = true
            cardsCollectionView.bottomAnchor.constraint(equalTo: controlButtonsStackView.topAnchor, constant: -24).isActive = true
            // Setup controlButtonsStackView constraints
            controlButtonsStackView.leadingAnchor.constraint(equalTo: gameInfoImageView.leadingAnchor, constant: 16).isActive = true
            controlButtonsStackView.trailingAnchor.constraint(equalTo: gameInfoImageView.trailingAnchor, constant: -16).isActive = true
            controlButtonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32).isActive = true
            // Setup settingsView constraints
            settingsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
            settingsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
            settingsView.centerInSuperView(view)
        }
}

//MARK: Setup buttons
extension GameViewController {
    func setupButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingsButton)
        settingsButton.addTarget(self, action: #selector(showSettings), for: .touchUpInside)
        goBackButton.addTarget(self, action: #selector(returnToMenu), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(pauseGame), for: .touchUpInside)
        refreshButton.addTarget(self, action: #selector(refreshGame), for: .touchUpInside)
    }
    
    @objc func showSettings() {
        cardsCollectionView.isHidden.toggle()
        settingsView.isHidden.toggle()
    }
    
    @objc func returnToMenu() {
        goToMainMenu()
    }
    
    @objc func refreshGame() {
        viewModel?.refreshButtonDidTapped()
        updateSnapshot()
    }
    
    @objc func pauseGame() {
        viewModel?.pauseButtonDidTapped()
    }
}

