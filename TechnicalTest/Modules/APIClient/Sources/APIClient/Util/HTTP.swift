//
//  HTTP.swift
//  APIClient
//
//  Created by Ainhoa Calviño Rodríguez on 20/5/25.
//

import Foundation

public enum HTTP {
    public typealias StatusCode = Int

    public enum Method: String {
        case GET
        case DELETE
        case POST
        case PUT
    }
}

extension HTTP {
    public enum HeaderName: String {
        case accept = "Accept"
        case contentType = "Content-Type"
    }
}

extension HTTP {
    public enum MIMEType {
        static let json = "application/json"
    }
}

extension URLRequest {
    mutating func setHeader(_ name: String, value: String) {
        setValue(value, forHTTPHeaderField: name)
    }
}
