//
//  ViewController.swift
//  LordOfTheQuotes
//
//  Created by Matteo Orru on 24/04/25.
//

import UIKit
import Combine


class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel
    private var cancellables = Set<AnyCancellable>()
    
    
    private var backgroundImageView: UIImageView!
    private var stackView: UIStackView!
    private var fellowshipButton: UIButton!
    private var twoTowersButton: UIButton!
    private var returnKingButton: UIButton!
    private var infoButton: UIButton!
    
    
    
    // MARK: - Initialization
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.loadMovies()
    }
    
    
    
    // MARK: - UI Setup
    private func setupUI() {
        //view.backgroundColor = .systemBackground
        
        let backgroundImageView = UIImageView(image: UIImage(named: "homeBackground2.jpg"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.addBlurEffect(style: .regular, alpha: 0.8)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        backgroundImageView.pinToEdges(of: view)
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        let fellowshipStackView = createMovieSection(title: "Fellowship of the Ring", imageName: "fellowshipButton.png")
        let towersStackView = createMovieSection(title: "The Two Towers", imageName: "twoTowersButton.jpg")
        let kingStackView = createMovieSection(title: "The Return of the King", imageName: "returnOfTheKingButton.jpg")
        
        stackView.addArrangedSubview(fellowshipStackView)
        stackView.addArrangedSubview(towersStackView)
        stackView.addArrangedSubview(kingStackView)
        
        infoButton = UIButton(type: .system)
        infoButton.setTitle("Info", for: .normal)
        infoButton.backgroundColor = .lightGray
        infoButton.setTitleColor(.black, for: .normal)
        infoButton.layer.cornerRadius = 20
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        view.addSubview(infoButton)
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            infoButton.widthAnchor.constraint(equalToConstant: 120),
            infoButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    private func createMovieButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .darkGray
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(movieButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    
    private func createMovieSection(title: String, imageName: String) -> UIStackView {
        let containerStack = UIStackView()
        containerStack.axis = .vertical
        containerStack.spacing = 10
        containerStack.alignment = .center
        
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: imageName), for: .normal)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(movieButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        titleLabel.textAlignment = .center
        
        containerStack.addArrangedSubview(button)
        containerStack.addArrangedSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 150),
            button.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        return containerStack
    }
    
    
    // MARK: - Binding
    private func bindViewModel() {
        viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
            }
            .store(in: &cancellables)
        
        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                if let error = error {
                    print("Error: \(error.errorMessage)")
                }
            }
            .store(in: &cancellables)
    }
    
    
    
    // MARK: - Actions
    @objc private func movieButtonTapped(_ sender: UIButton) {
    }
    
    @objc private func infoButtonTapped() {
    }
    
    
}//class

