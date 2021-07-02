//
//  CharactersListViewController.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import UIKit

class CharactersListViewController: BaseViewController {
    
    private struct Parameters {
        // Defines scroll offset value to request more characters
        static let requestingOffset: CGFloat = 100.0
    }
    
    // MARK: Properties

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(cellType: CharacterTableViewCell.self)
        return tableView
    }()
    
    private let viewModel: CharactersListViewModel
        
    // MARK: - Init
    
    init(viewModel: CharactersListViewModel) {
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
        viewModel.fetchCharacters()
    }

    // MARK: Methods

    private func configureView() {
        // TableView
        view.addSubview(tableView)
        tableView.setConstraintsFillToSuperview()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func navigateToDetail(of character: Character) {
        let viewModel = CharacterDetailViewModel(character: character)
        let viewController = CharacterDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: Data binding
    
    override func reloadData() {
        tableView.reloadData()
    }
}

// MARK: UITableViewDataSource

extension CharactersListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: CharacterTableViewCell.self, for: indexPath)
        
        let character = viewModel.getCharacter(by: indexPath)
        cell.configureView(with: character)
        
        return cell
    }
}

// MARK: UITableViewDelegate

extension CharactersListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let character = viewModel.getCharacter(by: indexPath) else { return }
        navigateToDetail(of: character)
    }
    
    // Request more characters when scroll reach a value
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height
    
        // Avoid when is already requesting, scrolling up, there is not content or Y offset not reach Parameters.requestingOffset
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if !isLoading && translation.y < 0 && maxOffset > 0.0 && maxOffset - yOffset < Parameters.requestingOffset {
            viewModel.fetchCharacters()
        }
    }
}
