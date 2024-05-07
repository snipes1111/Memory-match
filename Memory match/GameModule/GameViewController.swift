//
//  GameViewController.swift
//  Memory match
//
//  Created by user on 06/05/2024.
//

import UIKit

class GameViewController: UIViewController {
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.configureWith(image: .gameBackground, contentMode: .scaleAspectFill)
        return imageView
    }()
    
    private lazy var gameInfoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.configureWith(image: .timerFrame, contentMode: .scaleAspectFit)
        return imageView
    }()

    private lazy var settingsButton: UIButton = {
        var button = UIButton()
        button.configureWith(image: .settings)
        return button
    }()
    
    private lazy var pauseButton: UIButton = {
        var button = UIButton()
        button.configureWith(image: .pause)
        button.setSize(width: 50, height: 50)
        return button
    }()
    
    private lazy var goBackButton: UIButton = {
        var button = UIButton()
        button.configureWith(image: .goBack)
        button.setSize(width: 50, height: 50)
        return button
    }()
    
    private lazy var refreshButton: UIButton = {
        var button = UIButton()
        button.configureWith(image: .refresh)
        button.setSize(width: 50, height: 50)
        return button
    }()
    
    private lazy var movesLabel: UILabel = {
        let label = UILabel()
        label.configureWith(text: "MOVES:", font: .boldSystemFont(ofSize: 16))
        return label
    }()
    
    private lazy var numberOfMovesLabel: UILabel = {
        let label = UILabel()
        label.configureWith(text: "0", font: .boldSystemFont(ofSize: 16))
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.configureWith(text: "TIME:", font: .boldSystemFont(ofSize: 16))
        return label
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.configureWith(text: "00:00", font: .boldSystemFont(ofSize: 16))
        return label
    }()
    
    private lazy var gameInfoStackView: UIStackView = {
        let movesStackView = HorizontalStackView([movesLabel, numberOfMovesLabel], spacing: 4)
        let timeStackView = HorizontalStackView([timeLabel, timerLabel], spacing: 4)
        let stackView = HorizontalStackView([movesStackView, UIView(), timeStackView])
        return stackView
    }()
    
    private lazy var controlButtonsStackView: UIStackView = {
        let stackView = HorizontalStackView([pauseButton, goBackButton, refreshButton])
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private(set) lazy var cardsCollectionView: UICollectionView = {
        CardsCollectionView(superViewWidth: view.bounds.width, itemsPerRow: 4)
    }()
    
    // MARK: CollectionView
    var dataSource: DataSource?
    let data = Array(1...20)
    lazy var cellConfigurationHandler = UICollectionView.CellRegistration(handler: configureCell)
    
    override func viewDidLoad() {
        commonInit()
    }
    
    override func viewDidLayoutSubviews() {
        makeConstraints()
    }
    
    private func commonInit() {
        createCustomLeftBarButton()
        addSubviews()
        dataSource = makeDataSource()
        cardsCollectionView.dataSource = dataSource
        updateSnapshot()
    }
}

//MARK: - Extensions
private extension GameViewController {
// Setup Views
    func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(gameInfoImageView)
        gameInfoImageView.addSubview(gameInfoStackView)
        view.addSubview(controlButtonsStackView)
        view.addSubview(cardsCollectionView)
    }
    
    func makeConstraints() {
        // Setup backgroundImageView constraints
        backgroundImageView.fillSuperView(view)
        // Setup gameInfoImageView constraints
        gameInfoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        gameInfoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        gameInfoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        gameInfoImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // Setup settingsButton constraints
        settingsButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        // Setup gameInfoStackView constraints
        gameInfoStackView.leadingAnchor.constraint(equalTo: gameInfoImageView.leadingAnchor, constant: 32).isActive = true
        gameInfoStackView.trailingAnchor.constraint(equalTo: gameInfoImageView.trailingAnchor, constant: -32).isActive = true
        gameInfoStackView.topAnchor.constraint(equalTo: gameInfoImageView.topAnchor, constant: 16).isActive = true
        gameInfoStackView.bottomAnchor.constraint(equalTo: gameInfoImageView.bottomAnchor, constant: -16).isActive = true
        // Setup controlButtonsStackView constraints
        controlButtonsStackView.leadingAnchor.constraint(equalTo: gameInfoImageView.leadingAnchor, constant: 16).isActive = true
        controlButtonsStackView.trailingAnchor.constraint(equalTo: gameInfoImageView.trailingAnchor, constant: -16).isActive = true
        controlButtonsStackView.topAnchor.constraint(equalTo: cardsCollectionView.bottomAnchor, constant: 75).isActive = true
        controlButtonsStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32).isActive = true
        // Setup cardsCollectionView constraints
        cardsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cardsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cardsCollectionView.topAnchor.constraint(equalTo: gameInfoImageView.bottomAnchor, constant: 24).isActive = true
        cardsCollectionView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: -200).isActive = true
    }
    // Setup buttons
    func createCustomLeftBarButton() {
        let action = UIAction { [weak self] _ in
            self?.navigationController?.pushViewController(UIViewController(), animated: true)
        }
        settingsButton.addAction(action, for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingsButton)
    }
}
