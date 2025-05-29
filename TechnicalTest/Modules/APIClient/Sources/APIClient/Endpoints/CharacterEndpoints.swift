//
//  CharacterEndpoints.swift
//  APIClient
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

import Foundation

public enum CharacterEndpoints {
    public struct GetAllCharacters: Endpoint {
        public typealias ResponseBody = CharacterListResponseDTO

        public var path: String { "character"}
    }

    public struct GetCharacter: Endpoint {
        public typealias ResponseBody = CharacterDTO

        public let id: Int
        public var path: String { "character/\(id)"}
    }
}
