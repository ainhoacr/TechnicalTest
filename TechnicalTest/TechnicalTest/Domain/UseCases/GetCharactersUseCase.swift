//
//  GetCharactersUseCase.swift
//  TechnicalTest
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

import Foundation
import APIClient

public protocol GetCharactersUseCaseProtocol {
    func execute() async throws -> [Character]
}

public final class GetCharactersUseCase: GetCharactersUseCaseProtocol {
    private let repository: CharacterRepository
    
    public init(repository: CharacterRepository) {
        self.repository = repository
    }
    
    public func execute() async throws -> [Character] {
        return try await repository.fetchAllCharacters()
    }
}
