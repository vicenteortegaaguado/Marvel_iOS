//
//  BaseViewController.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import UIKit

class BaseViewController: UIViewController, AlertHandler, LoadingHandler {
    
    // MARK: - Properties
    
    private let viewModel: BaseViewModel
    
    // MARK: - Init
    
    init(viewModel: BaseViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Deinitialization control
    deinit {
        print("Deinit \(self)")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        bind()
    }

    // MARK: - Methods
    
    private func configureLoading(_ isLoading: Bool) {
        isLoading
            ? showLoading()
            : hideLoading()
    }
    
    func reloadData() {
        // To be override
    }
    
    func showError(_ error: MarvelError, _ responders: [(title: String, isDefault: Bool, handler: (() -> Void)?)]) {
        var buttons: [AlertButton] = []
        for responder in responders {
            buttons.append((title: responder.title,
                            style: responder.isDefault ? .default : .destructive,
                            handler: { _ in
                                responder.handler?()
                            }))
        }
        showDialog(withTitle: error.title, message: error.status, buttons: buttons)
    }
}

// MARK: - Data binding

private extension BaseViewController {
    
    func bind() {
        
        viewModel.loadingHandler = { [weak self] isLoading in
            self?.configureLoading(isLoading)
        }
        
        viewModel.dataHandler = { [weak self] in
            self?.reloadData()
        }
        
        viewModel.errorHandler = { [weak self] (error, responders) in
            self?.showError(error, responders)
        }
    }
}

