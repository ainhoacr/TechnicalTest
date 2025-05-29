//
//  CharacterEndpointsTests.swift
//  APIClient
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

import Testing
import Foundation
@testable import APIClient

@Suite("CharacterEndpointsTests", .serialized)
struct CharacterEndpointsTests {

    @Test("GetAllCharacters generates correct URL and method")
    func getAllCharactersGeneratesCorrectRequest() throws {
        let endpoint = CharacterEndpoints.GetAllCharacters()
        let baseURL = URL(string: "https://rickandmortyapi.com/api/")!

        let request = try endpoint.request(baseUrl: baseURL, body: Empty.empty)

        #expect(request.url?.absoluteString == "https://rickandmortyapi.com/api/character")
        #expect(request.httpMethod == "GET")
    }

    @Test("GetAllCharacters generates incorrect URL and method")
    func getAllCharactersGeneratesIncorrectRequest() throws {
        let endpoint = CharacterEndpoints.GetAllCharacters()

        let invalidBaseURL = URL(string: "")!

        #expect(throws: APIError.client) {
            _ = try endpoint.request(baseUrl: invalidBaseURL, body: Empty.empty)
        }
    }
}
