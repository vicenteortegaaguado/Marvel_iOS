//
//  CharactersRepository.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import Foundation

protocol CharactersRepositoryProtocol: Repository {
    func getCharacters(limit: Int, offset: Int, completion: @escaping ((Result<CharacterDataContainer?, ErrorType>) -> Void))
    func getCharacter(_ id: Int, completion: @escaping ((Result<Character?, ErrorType>) -> Void))
}

final class CharactersRepository: CharactersRepositoryProtocol {
    
    private let communicationManager: CommunicationProtocol
    
    init(communicationManager: CommunicationProtocol = CommunicationManager()) {
        self.communicationManager = communicationManager
    }

    func getCharacters(limit: Int, offset: Int, completion: @escaping ((Result<CharacterDataContainer?, ErrorType>) -> Void)) {
        communicationManager.request(CharactersEndpoint.characters(limit: limit, offset: offset), model: CharacterDataContainer.self) { (result) in
            switch result {
            case .success(var charactersContainer):
                // Discard characters with null id
                let filtered = charactersContainer?.results?.filter({ $0.id != nil })
                charactersContainer?.results = filtered
                completion(.success(charactersContainer))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCharacter(_ id: Int, completion: @escaping ((Result<Character?, ErrorType>) -> Void)) {
        communicationManager.request(CharactersEndpoint.character(id: id), model: CharacterDataContainer.self) { (result) in
            switch result {
            case .success(let charactersContainer):
                let character = charactersContainer?.results?.first(where: { $0.id != nil })
                completion(.success(character))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
