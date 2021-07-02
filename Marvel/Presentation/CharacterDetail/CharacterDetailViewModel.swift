//
//  CharacterDetailViewModel.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import Foundation

final class CharacterDetailViewModel: BaseViewModel {
    
    // MARK: Properties
    
    private let charactersRepository: CharactersRepositoryProtocol
    private(set) var character: Character {
        didSet {
            notifyData()
        }
    }
    
    // MARK: Init
    
    init(character: Character, charactersRepository: CharactersRepositoryProtocol = CharactersRepository()) {
        self.character = character
        self.charactersRepository = charactersRepository
    }
    
    // MARK: Methods
    
    /**
     It can be useful for getting characters directly if character id is known
     For example show favorites when characters ids are known (saved in local memory)
     */
    func fetchCharacter() {
        // Checking to avoid request character data twice
        guard character.isEmpty,
              let id = character.id else {
            notifyData()
            return
        }
        notify(isLoading: true)
        charactersRepository.getCharacter(id) { [weak self, character] (result) in
            self?.notify(isLoading: false)
            switch result {
            case .success(let updatedCharacter):
                self?.character = updatedCharacter ?? character
            case .failure(let error):
                self?.notify(error, responders: [
                    (title: "Close", isDefault: true, handler: nil),
                    (title: "Retry", isDefault: true, handler: { [weak self] in
                        self?.fetchCharacter()
                    })
                ])
            }
        }
    }
}
