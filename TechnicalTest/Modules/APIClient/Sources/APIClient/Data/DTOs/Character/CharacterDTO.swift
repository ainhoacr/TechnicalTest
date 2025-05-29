//
//  CharacterDTO.swift
//  APIClient
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

public struct CharacterDTO: Decodable, Sendable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String
    public let gender: String
    public let origin: LocationReferenceDTO
    public let location: LocationReferenceDTO
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String

    public func toDomain() -> Character {
        .init(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            origin: origin.toDomain(),
            location: location.toDomain(),
            image: image,
            episode: episode,
            url: url,
            created: created
        )
    }
}

public struct LocationReferenceDTO: Decodable, Sendable {
    public let name: String
    public let url: String

    public func toDomain() -> LocationReference {
        .init(name: name, url: url)
    }
}
