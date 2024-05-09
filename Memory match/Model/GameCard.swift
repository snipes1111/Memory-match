//
//  GameCard.swift
//  Memory match
//
//  Created by user on 07/05/2024.
//

import Foundation

struct GameCard: Identifiable, Hashable {
    let id: UUID
    let image: String
    var isHidden: Bool
    var isActive: Bool
    
    init(id: UUID = UUID(), image: String, isHidden: Bool = true, isActive: Bool = true) {
        self.id = id
        self.image = image
        self.isHidden = isHidden
        self.isActive = isActive
    }
}

extension GameCard {
    static func createGameData() -> [GameCard] {
        // fill arr with cards
        var arr = (1...8).flatMap { [$0, $0] }
        // add another 4 elements, because there are only 8 in th assets
        let additionalElemenets = arr.shuffled().prefix(2).flatMap { [$0, $0] }
        arr += additionalElemenets
        let cards = arr.map { GameCard(image: "slot\($0)") }
        return cards.shuffled()
    }
}
