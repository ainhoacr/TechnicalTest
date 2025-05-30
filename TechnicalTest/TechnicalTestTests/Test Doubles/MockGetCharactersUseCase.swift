//
//  MockGetCharactersUseCase.swift
//  TechnicalTest
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

@testable import TechnicalTest
@testable import APIClient

final class MockGetCharactersUseCase: GetCharactersUseCaseProtocol {
    var charactersToReturn: [Character] = []
    var shouldThrowError = false
    var errorToThrow: Error = APIError.failed
    var executeCallCount = 0

    func execute() async throws -> [Character] {
        executeCallCount += 1
        if shouldThrowError {
            throw errorToThrow
        }
        return charactersToReturn
    }
}
