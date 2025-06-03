//
//  Character.swift
//  APIClient
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

import Foundation

public enum CharacterStatus: String, Sendable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"

    public init(rawValue: String) {
        switch rawValue.lowercased() {
        case "alive":
            self = .alive
        case "dead":
            self = .dead
        default:
            self = .unknown
        }
    }
}

public struct Character: Identifiable, Sendable {
    public let id: Int
    public let name: String
    public let status: CharacterStatus
    public let species: String
    public let type: String
    public let gender: String
    public let origin: LocationReference
    public let location: LocationReference
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String

    public init(
        id: Int,
        name: String,
        status: String,
        species: String,
        type: String,
        gender: String,
        origin: LocationReference,
        location: LocationReference,
        image: String,
        episode: [String],
        url: String,
        created: String
    ) {
        self.id = id
        self.name = name
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
        self.status = CharacterStatus(rawValue: status)
    }
}

public struct LocationReference: Sendable {
    public let name: String
    public let url: String

    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
