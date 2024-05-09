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
    
    @Published var currentTime: String = "00:00"
    @Published var moves: Int = 0
    @Published var gameCards: [GameCard] = []
    @Published var gameIsStopped: Bool = false
    @Published var gameIsFinished: Bool = false
    private var openedCards: [GameCard] = []
    private var gameIsStarted: Bool = false
    
    init() {
        subscribeToTimer()
        fetchCards()
    }
    
    private func fetchCards() {
        gameService.$gameCards
            .assign(to: &$gameCards)
    }
    
    private func subscribeToTimer() {
        gameService.$currentTime
            .assign(to: &$currentTime)
    }
    
    func cardDidTapped(_ item: GameCard, completion: () -> ()) {
        guard item.isHidden else { return }
        if !gameIsStarted {
            gameIsStarted = true
            gameService.startGame()
        }
        if openedCards.count == 2 {
            checkOpenedCards()
        }
        showCards(item)
        checkForWin()
        completion()
    }
    
    private func showCards(_ item: GameCard) {
        guard let idx = gameCards.firstIndex(of: item) else { return }
        gameCards[idx].isHidden.toggle()
        moves += 1
        openedCards.append(item)
    }
    
    private func checkForWin() {
        print(gameCards.filter({ $0.isHidden }).count)
        if gameCards.filter({ $0.isHidden }).isEmpty {
            gameIsFinished = true
            gameService.pauseTimer()
        }
        return
    }
    
    private func checkOpenedCards() {
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
}

