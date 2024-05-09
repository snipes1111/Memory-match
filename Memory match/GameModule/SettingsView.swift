//
//  SettingsView.swift
//  Memory match
//
//  Created by user on 07/05/2024.
//

import UIKit

final class SettingsView: UIView {
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.configureWith(image: .settingsBackground, contentMode: .scaleAspectFill)
        return imageView
    }()
    
    private lazy var resumeButton: UIButton = {
        var button = UIButton()
        button.configureWith(image: .resume)
        return button
    }()
    
    private lazy var mainMenuButton: UIButton = {
        var button = UIButton()
        button.configureWith(image: .mainMenu)
        return button
    }()
    
    private lazy var muteButton: UIButton = {
        var button = UIButton()
        button.configureWith(image: .volumeOn)
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    private lazy var vibroButton: UIButton = {
        var button = UIButton()
        button.configureWith(image: .vibroOn)
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        makeConstraints()
    }
}

private extension SettingsView {
    
    func addSubviews() {
        addSubview(backgroundImageView)
    }
    
    func makeConstraints() {
        // Setup backgroundImageView constraints
        backgroundImageView.fillSuperView(self)
        // Setup button constraints
        let hStack = HorizontalStackView([muteButton, UIView(), vibroButton], spacing: 0)
        let vStack = UIStackView(arrangedSubviews: [resumeButton, mainMenuButton, hStack])
        vStack.axis = .vertical
        vStack.distribution = .fillEqually
        vStack.spacing = 24
        vStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(vStack)
        vStack.topAnchor.constraint(equalTo: topAnchor, constant: 48).isActive = true
        vStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
        vStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6).isActive = true
        vStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
