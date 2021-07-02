//
//  CharacterDetailViewController.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import UIKit

class CharacterDetailViewController: BaseViewController {
    
    // MARK: Properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints =
            false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.alignment = .center
        return stackView
    }()
    
    private let imageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.applyShadow()
        view.layer.cornerRadius = 15.0
        return view
    }()
    
    private let coverImageView: UIImageView = {
        let constant: CGFloat = 140.0
        let imageView = UIImageView(image: UIImage(systemName: "star.circle.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: constant).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: constant).isActive = true
        imageView.layer.cornerRadius = 15.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let titleLabel: BaseLabel = {
        let label = BaseLabel(style: .title)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: BaseLabel = {
        let label = BaseLabel(style: .description)
        label.numberOfLines = 0
        return label
    }()
    
    private let viewModel: CharacterDetailViewModel
    
    // MARK: Init
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        viewModel.fetchCharacter()
    }
    
    // MARK: Methods
    
    private func configureView(){
        view.addSubview(scrollView)
        scrollView.setConstraintsFillToSuperview()
        
        scrollView.addSubview(mainStackView)
        mainStackView.setConstraintsFillToSuperview(bottom: view.safeAreaInsets.bottom)
        mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        let heightAnchor = mainStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightAnchor.priority = .defaultLow
        heightAnchor.isActive = true
                
        mainStackView.addArrangedSubview(imageContainerView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(descriptionLabel)
        
        imageContainerView.addSubview(coverImageView)
        coverImageView.setConstraintsFillToSuperview()
    }
    
    override func reloadData() {
        let url = viewModel.character.thumbnail?.getURL(with: .standard(.large))
        coverImageView.load(url: url, placeholder: UIImage(systemName: "star.circle.fill"))
        titleLabel.text = viewModel.character.name
        descriptionLabel.text = viewModel.character.description
    }
}

