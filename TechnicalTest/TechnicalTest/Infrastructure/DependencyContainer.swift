//
//  DependencyContainer.swift
//  TechnicalTest
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

import Foundation
import APIClient

@MainActor
final class DependencyContainer {
    static let shared = DependencyContainer()
    
    private init() {}
    
    // MARK: - Repositories
    lazy var characterRepository: CharacterRepository = {
        CharacterRepositoryImpl(apiClient: APIClient())
    }()
    
    // MARK: - Use Cases
    lazy var getCharactersUseCase: GetCharactersUseCaseProtocol = {
        GetCharactersUseCase(repository: characterRepository)
    }()
    
    // MARK: - ViewModels
    func makeCharacterListViewModel() -> CharacterListViewModel {
        CharacterListViewModel(getCharactersUseCase: getCharactersUseCase)
    }
}
