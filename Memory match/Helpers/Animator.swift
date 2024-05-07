//
//  Animator.swift
//  Memory match
//
//  Created by user on 06/05/2024.
//

import UIKit

class Animator {
    func addLoadAnimation(view: UIView, duration: Double, distance: Double = 50) {
        let startY = view.frame.origin.y
        let endY = startY - distance
        
        UIView.animate(withDuration: duration, delay: 0, options: [.autoreverse, .repeat]) {
            view.frame.origin.y = endY
        }
    }
}
