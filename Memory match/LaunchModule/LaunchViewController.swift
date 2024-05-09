//
//  LaunchViewController.swift
//  Memory match
//
//  Created by user on 03/05/2024.
//

import UIKit

final class LaunchViewController: UIViewController {
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.configureWith(image: .startScreenBackground, contentMode: .scaleAspectFill)
        return imageView
    }()
    
    private lazy var fireImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.configureWith(image: .fire, contentMode: .scaleAspectFit)
        return imageView
    }()
    
    private lazy var loadingLabel: UILabel = {
        let label = UILabel()
        label.configureWith(text: "Loading...", font: .systemFont(ofSize: 24))
        return label
    }()
    
    private let animator = Animator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateFireImageView(duration: 1.5)
        performTransitionAfter(3.0)
    }
    
    override func viewDidLayoutSubviews() {
        setupConstraints()
    }
}

// MARK: - Extensions
private extension LaunchViewController {
    // Add vertical animation
    func animateFireImageView(duration: Double) {
        animator.addLoadAnimation(view: fireImageView, duration: duration)
    }
    // Simulate loading date to show animtion
    func performTransitionAfter(_ delay: Double) {
        guard let fromView = self.navigationController?.view else { return }
        animator.animateTransition(delay: delay, fromView: fromView) { [weak self] in
            self?.navigationController?.pushViewController(MenuViewController(), animated: false)
        }
    }
    
    func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(loadingLabel)
        view.addSubview(fireImageView)
    }
    
    func setupConstraints() {
        //setup backgroundImageView constraints
        backgroundImageView.fillSuperView(view)
        //setup loadingLabel constraints
        loadingLabel.centerInSuperView(view)
        //setup fireImageView constraints
        fireImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        fireImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        fireImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        fireImageView.bottomAnchor.constraint(equalTo: loadingLabel.topAnchor,
                                              constant: -10).isActive = true
    }
}
