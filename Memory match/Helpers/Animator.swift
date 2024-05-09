//
//  Animator.swift
//  Memory match
//
//  Created by user on 06/05/2024.
//

import UIKit

final class Animator {
    func addLoadAnimation(view: UIView, duration: Double, distance: Double = 50) {
        let startY = view.frame.origin.y
        let endY = startY - distance
        
        UIView.animate(withDuration: duration, delay: 0, options: [.autoreverse, .repeat]) {
            view.frame.origin.y = endY
        }
    }
    
    func animateTransition(delay: Double = 0, fromView: UIView, duration: Double = 0.6, _ completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UIView.transition(with: fromView, duration: duration, options: .transitionCrossDissolve) {
                completion()
            }
        }
    }
}
