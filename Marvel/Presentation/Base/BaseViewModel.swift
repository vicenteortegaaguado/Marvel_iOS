//
//  BaseViewModel.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import Foundation

class BaseViewModel {

    // MARK: Properties
    
    // Loading process notifier
    var loadingHandler: ((_ isLoading: Bool) -> Void)?
    // Data ready notifier
    var dataHandler: (() -> Void)?
    // Alert dialog configuration
    var errorHandler: ((MarvelError, [(title: String, isDefault: Bool, handler: (() -> Void)?)]) -> Void)?
    
    // MARK: Init
    
    // Deinitialization control
    deinit {
        print("Deinit \(self)")
    }
    
    // MARK: Methods
    
    func notify(isLoading: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.loadingHandler?(isLoading)
        }
    }
    
    func notifyData() {
        DispatchQueue.main.async { [weak self] in
            self?.dataHandler?()
        }
    }
    
    func notify(_ error: MarvelError, responders: [(title: String, isDefault: Bool, handler: (() -> Void)?)] = [(title: "Close", isDefault: true, handler: nil)]) {
        DispatchQueue.main.async { [weak self] in
            self?.errorHandler?(error, responders)
        }
    }
}

