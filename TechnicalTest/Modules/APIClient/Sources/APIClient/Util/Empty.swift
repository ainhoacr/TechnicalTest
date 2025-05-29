//
//  Empty.swift
//  APIClient
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

public struct Empty: Codable, Equatable, Sendable {
    public static let empty = Empty()

    public init() {}
}
