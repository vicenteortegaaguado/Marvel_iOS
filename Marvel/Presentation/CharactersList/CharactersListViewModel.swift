//
//  CharactersListViewModel.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import Foundation

final class CharactersListViewModel: BaseViewModel {
    
    // MARK: Properties
    
    private let charactersRepository: CharactersRepositoryProtocol
    private var charactersContainer: CharacterDataContainer? {
        didSet {
            notifyData()
        }
    }
    /// Number of characters to request in each block
    /// Min: 1
    /// Max: 100
    private var limit: Int { 10 }
    /// Current offset
    var numberOfRows: Int { charactersContainer?.results?.count ?? 0 }
    
    // MARK: Init
    
    init(marvelRepository: CharactersRepositoryProtocol = CharactersRepository()) {
        self.charactersRepository = marvelRepository
    }
    
    // MARK: Methods
    
    /// To update current character data
    private func update(value charactersContainer: CharacterDataContainer?) {
        // Avoid null values because is cached response
        guard var charactersContainer = charactersContainer,
              let newCharacters = charactersContainer.results else { return }
        var characters = self.charactersContainer?.results ?? []
        characters.append(contentsOf: newCharacters)
        charactersContainer.results? = characters
        self.charactersContainer = charactersContainer
    }
    
    /**
     To request for characters data.
     */
    func fetchCharacters() {
        notify(isLoading: true)
        charactersRepository.getCharacters(limit: limit, offset: numberOfRows) { [weak self] (result) in
            self?.notify(isLoading: false)
            switch result {
            case .success(let charactersContainer):
                self?.update(value: charactersContainer)
            case .failure(let error):
                self?.notify(error, responders: [
                    (title: "Retry", isDefault: true, { [weak self] in
                        self?.fetchCharacters()
                    })
                ])
            }
        }
    }
    
    /**
     To get specific character.
     - Parameter indexPath: defines the position in the characters list
     - Returns: An optional character.
     */
    func getCharacter(by indexPath: IndexPath) -> Character? {
        charactersContainer?.results?[indexPath.row]
    }
}
