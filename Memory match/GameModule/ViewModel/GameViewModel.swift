//
//  GameViewModel.swift
//  Memory match
//
//  Created by user on 07/05/2024.
//

import Foundation
import Combine

final class GameViewModel {
    private var gameService: GameService = GameService()
    
    @Published private(set) var currentTime: String = "00:00"
    @Published private(set) var moves: Int = 0
    @Published private(set) var gameCards: [GameCard] = []
    @Published private(set) var gameIsStopped: Bool = false
    @Published private(set) var gameIsFinished: Bool = false
    @Published private(set) var vibroIsOn: Bool = true
    @Published private(set) var soundIsOn: Bool = true
    private var openedCards: [GameCard] = []
    private var gameIsStarted: Bool = false
    
    init() {
        subscribeToTimer()
        fetchCards()
    }
    
    func pauseButtonDidTapped() {
        gameIsStopped.toggle()
        if gameIsStopped { gameService.pauseTimer() }
        else { gameService.continueTimer() }
    }
    
    func refreshButtonDidTapped() {
        gameIsStarted = false
        moves = 0
        openedCards.removeAll()
        gameService.reloadGame()
    }
    
    func cardDidTapped(_ item: GameCard, completion: () -> ()) {
        guard item.isHidden else { return }
        startGame()
        checkOpenedCards()
        showCards(item)
        performEffects()
        checkForWin()
        completion()
    }
    
    func switchVibro() {
        vibroIsOn.toggle()
    }
    
    func switchSound() {
        soundIsOn.toggle()
    }
    
    private func startGame() {
        guard !gameIsStarted else { return }
        gameIsStarted = true
        gameService.startGame()
    }
    
    private func performEffects() {
        print(soundIsOn)
        if vibroIsOn { gameService.performVibroFeedback() }
        if soundIsOn { gameService.playSound() }
        return
    }
    
    private func fetchCards() {
        gameService.$gameCards
            .assign(to: &$gameCards)
    }
    
    private func subscribeToTimer() {
        gameService.$currentTime
            .assign(to: &$currentTime)
    }
    
    private func showCards(_ item: GameCard) {
        guard let idx = gameCards.firstIndex(of: item) else { return }
        gameCards[idx].isHidden.toggle()
        moves += 1
        openedCards.append(item)
    }
    
    private func checkForWin() {
        if gameCards.filter({ $0.isHidden }).isEmpty {
            gameIsFinished = true
            gameService.pauseTimer()
        }
        return
    }
    
    private func checkOpenedCards() {
        guard openedCards.count == 2 else { return }
        guard let firstOpenedCard = openedCards.first,
              let secondOpenedCard = openedCards.last else { return }
        if firstOpenedCard.image == secondOpenedCard.image {
            changeCardsToInactive()
        } else {
            flipCards()
        }
    }
    
    private func changeCardsToInactive() {
        openedCards.forEach { card in
            guard let idx = gameCards.firstIndex(where: { $0.id == card.id }) else { return }
            gameCards[idx].isActive.toggle()
        }
        openedCards.removeAll()
    }
    
    private func flipCards() {
        openedCards.forEach { card in
            guard let idx = gameCards.firstIndex(where: { $0.id == card.id }) else { return }
            gameCards[idx].isHidden.toggle()
        }
        openedCards.removeAll()
    }
}

