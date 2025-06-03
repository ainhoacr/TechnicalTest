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

    @Test("GetCharacter generates correct request for given ID")
    func getCharacterGeneratesCorrectRequest() throws {
        let endpoint = CharacterEndpoints.GetCharacter(id: 42)
        let baseURL = URL(string: "https://rickandmortyapi.com/api/")!

        let request = try endpoint.request(baseUrl: baseURL, body: Empty.empty)

        #expect(request.url?.absoluteString == "https://rickandmortyapi.com/api/character/42")
        #expect(request.httpMethod == "GET")
        #expect(request.value(forHTTPHeaderField: "Accept") == "application/json")
    }
}
