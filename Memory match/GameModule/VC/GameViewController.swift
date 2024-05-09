//
//  GameViewController.swift
//  Memory match
//
//  Created by user on 06/05/2024.
//

import UIKit
import Combine

final class GameViewController: UIViewController {
    
    private(set) lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.configureWith(image: .gameBackground, contentMode: .scaleAspectFill)
        return imageView
    }()
    
    private(set) lazy var gameInfoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.configureWith(image: .timerFrame, contentMode: .scaleAspectFit)
        return imageView
    }()

    private(set) lazy var settingsButton: UIButton = {
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
    
    private(set) lazy var goBackButton: UIButton = {
        var button = UIButton()
        button.configureWith(image: .goBack)
        button.setSize(width: 50, height: 50)
        return button
    }()
    
    private(set) lazy var refreshButton: UIButton = {
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
    
    private(set) lazy var gameInfoStackView: UIStackView = {
        let stackView = HorizontalStackView([movesLabel, UIView(), timeLabel])
        return stackView
    }()
    
    private(set) lazy var controlButtonsStackView: UIStackView = {
        let stackView = HorizontalStackView([pauseButton, goBackButton, refreshButton])
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private(set) lazy var cardsCollectionView: UICollectionView = {
        CardsCollectionView(superViewWidth: view.bounds.width, itemsPerRow: 4)
    }()
    
    private(set) lazy var settingsView: SettingsView = {
        let view = SettingsView()
        view.delegate = self
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
    
    // MARK: CollectionViewDataSource
    var dataSource: DataSource?
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
        subscribeToGameActiveStatus()
        subscribeToGameInfo()
        subscribeToWinStatus()
        subscribeToSettings()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        cancellables.removeAll()
    }
    
    override func viewDidLayoutSubviews() {
        makeConstraints()
    }
    
    private func commonInit() {
        addSubviews()
        setupCollectionView()
        setupButtons()
    }
    
}

//MARK: - Extensions
extension GameViewController {
    func goToMainMenu() {
        guard let view = navigationController?.view else { return }
        animator.animateTransition(fromView: view) { [weak self] in
            self?.navigationController?.popViewController(animated: false)
        }
    }
    
    func addYouWinViewWithAnimation() {
        //set result to view labels
        youWinView.setResult(moves: "\(viewModel?.moves ?? 0)", time: viewModel?.currentTime)
        //add to main view
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
