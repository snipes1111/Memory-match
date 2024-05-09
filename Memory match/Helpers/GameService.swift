//
//  GameService.swift
//  Memory match
//
//  Created by user on 07/05/2024.
//

import Foundation
import Combine
import AVFoundation
import UIKit

final class GameService {
    
    @Published var gameCards: [GameCard] = []
    @Published var currentTime: String = "00:00"
    
    private lazy var timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        formatter.unitsStyle = .positional
        formatter.maximumUnitCount = 2
        return formatter
    }()
    
    private lazy var player: AVPlayer = AVPlayer.sharedFlipPlayer
    private lazy var feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    private var timeInterval: TimeInterval = 0
    private var cancellable: Set<AnyCancellable> = []
    
    init() {
        fetchGameCards()
    }
    
    func startGame() {
        feedbackGenerator.prepare()
        startTimer()
    }
    
    func pauseTimer() {
        cancellable.removeAll()
    }
    
    func continueTimer() {
        startTimer()
    }
    
    func reloadGame() {
        cancellable.removeAll()
        timeInterval = 0
        currentTime = "00:00"
        fetchGameCards()
    }
    
    func performVibroFeedback() {
        feedbackGenerator.impactOccurred()
    }
    
    func playSound() {
        DispatchQueue.main.async { [weak self] in
            self?.player.seek(to: .zero)
            self?.player.play()
        }
    }
}

extension GameService {
    private func secondsToHourMinFormat(time: TimeInterval) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        formatter.unitsStyle = .positional
        formatter.maximumUnitCount = 2
        return formatter.string(from: time)
    }
    
    private func setCurrentTime() {
        let formattedTime = timeFormatter.string(from: timeInterval) ?? "00:00"
        currentTime = formattedTime
    }
    
    private func fetchGameCards() {
        gameCards = GameCard.createGameData()
    }
    
    private func startTimer() {
        Timer.publish(every: 1, on: RunLoop.main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                self?.timeInterval += 1
                self?.setCurrentTime()
            }
            .store(in: &cancellable)
    }
}
