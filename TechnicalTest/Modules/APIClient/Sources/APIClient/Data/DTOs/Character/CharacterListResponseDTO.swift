//
//  CharacterListResponseDTO.swift
//  APIClient
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

import Foundation

public struct CharacterListResponseDTO: Decodable, Sendable {
    public let results: [CharacterDTO]
}
