//
//  StartScreenModule.swift
//  Memory match
//
//  Created by user on 06/05/2024.
//

import UIKit
import SafariServices

final class MenuViewController: UIViewController {
    
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
    
    private lazy var crownImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.configureWith(image: .crown, contentMode: .scaleAspectFit)
        return imageView
    }()
    
    private let playNowButton: UIButton = {
        var button = UIButton()
        button.configureWith(image: .playNow)
        button.setSize(width: 250, height: 50)
        return button
    }()
    
    private let privacyPolicyButton: UIButton = {
        var button = UIButton()
        button.configureWith(image: .privacyPolicy)
        button.setSize(width: 250, height: 50)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewDidLayoutSubviews() {
        setupConstraints()
    }
    
    private func commonInit() {
        navigationItem.hidesBackButton = true
        addSubviews()
        addButtonTargets()
    }
}

// MARK: - Extensions
private extension MenuViewController {
    func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(fireImageView)
        view.addSubview(crownImageView)
        view.addSubview(playNowButton)
        view.addSubview(privacyPolicyButton)
    }
    
    func setupConstraints() {
        //setup backgroundImageView constraints
        backgroundImageView.fillSuperView(view)
        //setup fireImageView constraints
        fireImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        fireImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        fireImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: -100).isActive = true
        fireImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        //setup crownImageView constraints
        crownImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: 20).isActive = true
        crownImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, 
                                                 constant: -20).isActive = true
        crownImageView.topAnchor.constraint(equalTo: view.topAnchor,
                                            constant: 80).isActive = true
        crownImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        //setup playNowButton constraints
        playNowButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playNowButton.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        //setup privacyPolicyButton constraints
        privacyPolicyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        privacyPolicyButton.topAnchor.constraint(equalTo: playNowButton.bottomAnchor, constant: 20).isActive = true
    }
    
    func addButtonTargets() {
        addPlayNowButtonAction()
        addPrivacyPolicyButtonAction()
    }
    
    func addPlayNowButtonAction() {
        playNowButton.addTarget(self, action: #selector(openGameVc), for: .touchUpInside)
    }
    
    @objc func openGameVc() {
        let vc = GameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func addPrivacyPolicyButtonAction() {
        privacyPolicyButton.addTarget(self, action: #selector(openSafariVc), for: .touchUpInside)
    }
    
    @objc func openSafariVc() {
        guard let url = URL(string: "https://www.apple.com/apple-events/event-stream/") else { return }
        let vc = createSafariVC(url: url)
        present(vc, animated: true)
    }
    
    func createSafariVC(url: URL) -> SFSafariViewController {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredBarTintColor = .black
        safariViewController.preferredControlTintColor = .white
        return safariViewController
    }
}
