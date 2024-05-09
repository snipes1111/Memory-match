//
//  GameViewController.swift
//  Memory match
//
//  Created by user on 06/05/2024.
//

import UIKit
import Combine

final class GameViewController: UIViewController {
    
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
    
    private(set) lazy var pauseButton: UIButton = {
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
    
    private lazy var gameInfoStackView: UIStackView = {
        let stackView = HorizontalStackView([movesLabel, UIView(), timeLabel])
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
    
    private(set) lazy var settingsView: SettingsView = {
        let view = SettingsView()
        view.isHidden = true
        return view
    }()
    
    private(set) lazy var youWinView: YouWinView = {
        let view = YouWinView()
        view.delegate = self
        view.isHidden = false
        return view
    }()
    
    private let animator = Animator()
    
    // MARK: CollectionView
    var dataSource: DataSource?
    lazy var cellConfigurationHandler = UICollectionView.CellRegistration(handler: configureCell)
    
    // MARK: ViewModel
    private(set) var viewModel: GameViewModel?
    
    //MARK: Subscriptions
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        viewModel = GameViewModel()
        commonInit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        subscribeToTimer()
        subscribeToGameActiveStatus()
        subscribeToMoves()
        subscribeToWinStatus()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        cancellables.removeAll()
    }
    
    override func viewDidLayoutSubviews() {
        makeConstraints()
    }
    
    private func commonInit() {
        createCustomLeftBarButton()
        addSubviews()
        setupCollectionView()
        addBackButtonAction()
        addPauseButtonAction()
        addRefreshButtonAction()
    }
    
    func goBack() {
        guard let view = navigationController?.view else { return }
        animator.animateTransition(fromView: view) { [weak self] in
            self?.navigationController?.popViewController(animated: false)
        }
    }
}

//MARK: - Extensions
private extension GameViewController {
// Setup Views
    func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(gameInfoImageView)
        gameInfoImageView.addSubview(gameInfoStackView)
        view.addSubview(cardsCollectionView)
        view.addSubview(controlButtonsStackView)
        view.addSubview(settingsView)
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
        // Setup cardsCollectionView constraints
        cardsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cardsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cardsCollectionView.topAnchor.constraint(equalTo: gameInfoImageView.bottomAnchor, constant: 24).isActive = true
        cardsCollectionView.bottomAnchor.constraint(equalTo: controlButtonsStackView.topAnchor, constant: -24).isActive = true
        // Setup controlButtonsStackView constraints
        controlButtonsStackView.leadingAnchor.constraint(equalTo: gameInfoImageView.leadingAnchor, constant: 16).isActive = true
        controlButtonsStackView.trailingAnchor.constraint(equalTo: gameInfoImageView.trailingAnchor, constant: -16).isActive = true
        controlButtonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32).isActive = true
        // Setup settingsView constraints
        settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        settingsView.topAnchor.constraint(equalTo: gameInfoImageView.bottomAnchor, constant: 64).isActive = true
        settingsView.bottomAnchor.constraint(lessThanOrEqualTo: controlButtonsStackView.topAnchor, constant: -150).isActive = true
    }
    // Setup buttons
    func createCustomLeftBarButton() {
        let action = UIAction { [weak self] _ in
            self?.cardsCollectionView.isHidden.toggle()
            self?.settingsView.isHidden.toggle()
        }
        settingsButton.addAction(action, for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingsButton)
    }
    
    func addBackButtonAction() {
        let action = UIAction { [weak self] _ in
            self?.goBack()
        }
        goBackButton.addAction(action, for: .touchUpInside)
    }
    
    func addPauseButtonAction() {
        let action = UIAction { [weak self] _ in
            self?.viewModel?.pauseButtonDidTapped()
        }
        pauseButton.addAction(action, for: .touchUpInside)
    }
    
    func addRefreshButtonAction() {
        let action = UIAction { [weak self] _ in
            self?.viewModel?.refreshButtonDidTapped()
            self?.updateSnapshot()
        }
        refreshButton.addAction(action, for: .touchUpInside)
    }
}

extension GameViewController {
    func addYouWinViewWithAnimation() {
        view.addSubview(youWinView)
        youWinView.fillSuperView(view)
        youWinView.alpha = 0
        youWinView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.youWinView.alpha = 1
            self.youWinView.transform = CGAffineTransform.identity
        })
    }
}
