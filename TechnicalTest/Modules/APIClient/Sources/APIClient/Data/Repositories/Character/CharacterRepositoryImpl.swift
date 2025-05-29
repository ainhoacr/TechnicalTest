//
//  CharacterRepositoryImpl.swift
//  APIClient
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

import Foundation

public final class CharacterRepositoryImpl: CharacterRepository {
    private let apiClient: APIClient

    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    public func fetchAllCharacters() async throws -> [Character] {
        let dto = try await apiClient.request(CharacterEndpoints.GetAllCharacters(), body: .empty)
        return dto.results.map { $0.toDomain() }
    }

    public func fetchCharacter(id: Int) async throws -> Character {
        let dto = try await apiClient.request(CharacterEndpoints.GetCharacter(id: id), body: .empty)
        return dto.toDomain()
    }
}
