//
//  MockCharacterRepository.swift
//  TechnicalTest
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

@testable import TechnicalTest
@testable import APIClient

final class MockCharacterRepository: CharacterRepository {
    var charactersToReturn: [Character] = []
    var shouldThrowError = false
    var fetchAllCharactersCalled = false

    func fetchAllCharacters() async throws -> [Character] {
        fetchAllCharactersCalled = true
        if shouldThrowError {
            throw APIError.failed
        }
        return charactersToReturn
    }

    func fetchCharacter(id: Int) async throws -> Character {
        fatalError("Not implemented")
    }
}
