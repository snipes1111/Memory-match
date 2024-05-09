//
//  WinView.swift
//  Memory match
//
//  Created by user on 08/05/2024.
//

import UIKit

final class YouWinView: UIView {
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.configureWith(image: .stars, contentMode: .scaleAspectFill)
        return imageView
    }()
    
    private lazy var fireImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.configureWith(image: .fire, contentMode: .scaleAspectFit)
        return imageView
    }()
    
    private lazy var youWinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.configureWith(image: .youWin, contentMode: .scaleToFill)
        return imageView
    }()
    
    private lazy var resultBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.configureWith(image: .resultFrame, contentMode: .scaleToFill)
        return imageView
    }()
    
    private lazy var refreshButton: UIButton = {
        var button = UIButton()
        button.configureWith(image: .refresh)
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    private lazy var menuButton: UIButton = {
        var button = UIButton()
        button.configureWith(image: .menu)
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    private(set) lazy var movesLabel: UILabel = {
        let label = UILabel()
        label.configureWith(text: "MOVES: 0", font: .boldSystemFont(ofSize: 16))
        return label
    }()
    
    private(set) lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.configureWith(text: "TIME: 00:00", font: .boldSystemFont(ofSize: 16))
        return label
    }()
    
    weak var delegate: YouWinViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        addOverlayView()
        addSubviews()
        makeConstraints()
        addButtonsTargets()
    }
}

private extension YouWinView {
    
    func addSubviews() {
        addSubview(backgroundImageView)
        addSubview(fireImageView)
        addSubview(resultBackground)
        addSubview(youWinImageView)
    }
    
    func makeConstraints() {
        // Setup backgroundImageView constraints
        backgroundImageView.fillSuperView(self)
        // Setup fireImageView constraints
        fireImageView.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        fireImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        fireImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        fireImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        // Setup resultBackground constraints
        resultBackground.topAnchor.constraint(equalTo: centerYAnchor).isActive = true
        resultBackground.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        resultBackground.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
        resultBackground.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        // Setup youWinImageView constraints
        youWinImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        youWinImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        youWinImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        youWinImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        // Setup buttons constraints
        createButtonStackView()
        createInfoLabelStackView()
    }
}

private extension YouWinView {
    func createButtonStackView() {
        let stackView = UIStackView()
        stackView.addArrangedSubviews([refreshButton, menuButton])
        stackView.spacing = 16
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: resultBackground.bottomAnchor, constant: 16).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func createInfoLabelStackView() {
        let stackView = UIStackView()
        stackView.addArrangedSubviews([movesLabel, timeLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.bottomAnchor.constraint(equalTo: resultBackground.bottomAnchor, constant: -20).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func addOverlayView() {
        let overlayView = UIView(frame: bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(overlayView)
    }
}

//MARK: - Delegate

protocol YouWinViewDelegate: AnyObject {
    func refreshButtonPressed()
    func menuButtonPressed()
}

private extension YouWinView {
    
    private func addButtonsTargets() {
        refreshButton.addTarget(self, action: #selector(refreshButtonDidTapped), for: .touchUpInside)
        menuButton.addTarget(self, action: #selector(menuButtonDidTapped), for: .touchUpInside)
    }
    
    @objc func refreshButtonDidTapped() {
        delegate?.refreshButtonPressed()
    }
    
    @objc func menuButtonDidTapped() {
        delegate?.menuButtonPressed()
    }
}
