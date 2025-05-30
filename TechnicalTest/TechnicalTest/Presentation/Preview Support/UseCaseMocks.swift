//
//  UseCaseMocks.swift
//  TechnicalTest
//
//  Created by Ainhoa Calviño Rodríguez on 1/6/25.
//

#if DEBUG
import APIClient

final class MockGetCharactersUseCase: GetCharactersUseCaseProtocol {
    let characters: [Character]
    let shouldThrow: Bool

    init(characters: [Character], shouldThrow: Bool = false) {
        self.characters = characters
        self.shouldThrow = shouldThrow
    }

    func execute() async throws -> [Character] {
        if shouldThrow {
            throw APIError.failed
        }
        return characters
    }
}
#endif
