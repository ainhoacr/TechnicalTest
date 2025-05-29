//
//  CharacterRepositoryImplTests.swift
//  APIClient
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

import Testing
import Foundation
@testable import APIClient

@Suite("CharacterRepositoryImpl Tests", .serialized)
struct CharacterRepositoryImplTests {
    @Test("getAllCharacters returns characters successfully")
    func getAllCharactersReturnsCharactersSuccessfully() async throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let apiClient = APIClient(session: session)
        let repository = CharacterRepositoryImpl(apiClient: apiClient)

        let json = """
        {
            "info": {
                "count": 2,
                "pages": 1,
                "next": null,
                "prev": null
            },
            "results": [
                {
                    "id": 1,
                    "name": "Rick Sanchez",
                    "status": "Alive",
                    "species": "Human",
                    "type": "",
                    "gender": "Male",
                    "origin": {
                        "name": "Earth (C-137)",
                        "url": "https://rickandmortyapi.com/api/location/1"
                    },
                    "location": {
                        "name": "Citadel of Ricks",
                        "url": "https://rickandmortyapi.com/api/location/3"
                    },
                    "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                    "episode": [
                        "https://rickandmortyapi.com/api/episode/1"
                    ],
                    "url": "https://rickandmortyapi.com/api/character/1",
                    "created": "2017-11-04T18:48:46.250Z"
                },
                {
                    "id": 2,
                    "name": "Morty Smith",
                    "status": "Alive",
                    "species": "Human",
                    "type": "",
                    "gender": "Male",
                    "origin": {
                        "name": "unknown",
                        "url": ""
                    },
                    "location": {
                        "name": "Citadel of Ricks",
                        "url": "https://rickandmortyapi.com/api/location/3"
                    },
                    "image": "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                    "episode": [
                        "https://rickandmortyapi.com/api/episode/1"
                    ],
                    "url": "https://rickandmortyapi.com/api/character/2",
                    "created": "2017-11-04T18:50:21.651Z"
                }
            ]
        }
        """

        await MockURLProtocolState.shared.setSuccess(
            data: json.data(using: .utf8)!,
            statusCode: 200
        )

        let characters = try await repository.fetchAllCharacters()

        #expect(characters.count == 2)
        #expect(characters[0].id == 1)
        #expect(characters[0].name == "Rick Sanchez")
        #expect(characters[1].id == 2)
        #expect(characters[1].name == "Morty Smith")
    }

    @Test("getAllCharacters returns empty list when no characters")
    func getAllCharactersReturnsEmptyListWhenNoCharacters() async throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let apiClient = APIClient(session: session)
        let repository = CharacterRepositoryImpl(apiClient: apiClient)

        let json = """
        {
            "info": {
                "count": 0,
                "pages": 0,
                "next": null,
                "prev": null
            },
            "results": []
        }
        """

        await MockURLProtocolState.shared.setSuccess(
            data: json.data(using: .utf8)!,
            statusCode: 200
        )

        let characters = try await repository.fetchAllCharacters()

        #expect(characters.isEmpty)
    }

    // MARK: - Error Cases

    @Test("getAllCharacters throws when API returns client error")
    func getAllCharactersThrowsWhenAPIReturnsClientError() async throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let apiClient = APIClient(session: session)
        let repository = CharacterRepositoryImpl(apiClient: apiClient)

        await MockURLProtocolState.shared.setSuccess(
            data: Data(),
            statusCode: 404
        )

        await #expect(throws: APIError.client) {
            try await repository.fetchAllCharacters()
        }
    }

    @Test("getAllCharacters throws when API returns server error")
    func getAllCharactersThrowsWhenAPIReturnsServerError() async throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let apiClient = APIClient(session: session)
        let repository = CharacterRepositoryImpl(apiClient: apiClient)

        await MockURLProtocolState.shared.setSuccess(
            data: Data(),
            statusCode: 500
        )

        await #expect(throws: APIError.server) {
            try await repository.fetchAllCharacters()
        }
    }

    @Test("getAllCharacters throws when network error occurs")
    func getAllCharactersThrowsWhenNetworkErrorOccurs() async throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let apiClient = APIClient(session: session)
        let repository = CharacterRepositoryImpl(apiClient: apiClient)

        let networkError = URLError(.notConnectedToInternet)
        await MockURLProtocolState.shared.setError(networkError)

        await #expect(throws: URLError.self) {
            try await repository.fetchAllCharacters()
        }
    }

    @Test("getAllCharacters throws when invalid JSON is received")
    func getAllCharactersThrowsWhenInvalidJSONReceived() async throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let apiClient = APIClient(session: session)
        let repository = CharacterRepositoryImpl(apiClient: apiClient)

        let invalidJSON = "{ invalid json }"
        await MockURLProtocolState.shared.setSuccess(
            data: invalidJSON.data(using: .utf8)!,
            statusCode: 200
        )

        await #expect(throws: DecodingError.self) {
            try await repository.fetchAllCharacters()
        }
    }
}
