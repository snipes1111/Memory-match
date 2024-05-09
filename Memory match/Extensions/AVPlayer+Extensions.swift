//
//  AVPlayer+Extensions.swift
//  Memory match
//
//  Created by user on 09/05/2024.
//

import AVFoundation

extension AVPlayer {
    static let sharedFlipPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "flip", withExtension: "mp3") else { fatalError("No sound was found") }
        return AVPlayer(url: url)
    }()
}
