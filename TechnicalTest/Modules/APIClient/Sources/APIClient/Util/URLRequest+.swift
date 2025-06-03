//
//  URLRequest+.swift
//  APIClient
//
//  Created by Ainhoa Calviño Rodríguez on 3/6/25.
//

import Foundation

extension URLRequest {
    private static let contextHeader = "X-Test-Context-ID"

    var contextID: String? {
        get { value(forHTTPHeaderField: Self.contextHeader) }
        set { setValue(newValue, forHTTPHeaderField: Self.contextHeader) }
    }
}
