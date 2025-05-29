//
//  APIError.swift
//  APIClient
//
//  Created by Ainhoa Calviño Rodríguez on 20/5/25.
//

import Foundation

public enum APIError: Error {
    case client
    case server
    case failed
}
