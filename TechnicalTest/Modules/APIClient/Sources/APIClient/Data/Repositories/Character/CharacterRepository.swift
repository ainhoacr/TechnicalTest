//
//  CharacterRepository.swift
//  APIClient
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

import Foundation

public protocol CharacterRepository {
    func fetchAllCharacters() async throws -> [Character]
    func fetchCharacter(id: Int) async throws -> Character
}
