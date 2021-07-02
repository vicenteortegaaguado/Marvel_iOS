//
//  CharacterTableViewCell.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import UIKit

final class CharacterTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.applyShadow()
        view.layer.cornerRadius = 15.0
        return view
    }()
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8.0
        return stack
    }()
    
    private let coverImageView: UIImageView = {
        let constant: CGFloat = 140.0
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: constant).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: constant).isActive = true
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        imageView.layer.cornerRadius = 15.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let textStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8.0
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let nameLabel: BaseLabel = BaseLabel(style: .title)
    private let comicsLabel: BaseLabel = BaseLabel(style: .description)
    private let storiesLabel: BaseLabel = BaseLabel(style: .description)
    private let eventsLabel: BaseLabel = BaseLabel(style: .description)
    private let seriesLabel: BaseLabel = BaseLabel(style: .description)
    
    // MARK: Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        coverImageView.image = nil
        comicsLabel.text = nil
        storiesLabel.text = nil
        eventsLabel.text = nil
        seriesLabel.text = nil
    }
    
    // MARK: Methods
    
    func configureView(with character: Character?) {
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        
        nameLabel.text = character?.name ?? "Unknown"
        
        let url = character?.thumbnail?.getURL(with: .standard(.large))
        coverImageView.load(url: url, placeholder: UIImage(systemName: "star.circle.fill"))
        
        comicsLabel.text = "Comics: \(character?.comics?.available ?? 0)"
        storiesLabel.text = "Stories: \(character?.stories?.available ?? 0)"
        eventsLabel.text = "Events: \(character?.events?.available ?? 0)"
        seriesLabel.text = "Series: \(character?.series?.available ?? 0)"
        
        // Avoid when reuse
        if containerView.superview == nil {
            // Container
            addSubview(containerView)
            containerView.setConstraintsFillToSafeArea(top: 16, leading: 16, trailing: -16, bottom: -16)
            // Stack horizontal container
            containerView.addSubview(containerStackView)
            containerStackView.setConstraintsFillToSafeArea()
            // Image and text stack vertical container
            containerStackView.addArrangedSubview(coverImageView)
            containerStackView.addArrangedSubview(textStackView)
            // Text labels
            textStackView.addArrangedSubview(nameLabel)
            textStackView.addArrangedSubview(comicsLabel)
            textStackView.addArrangedSubview(storiesLabel)
            textStackView.addArrangedSubview(eventsLabel)
            textStackView.addArrangedSubview(seriesLabel)
        }
    }
}
