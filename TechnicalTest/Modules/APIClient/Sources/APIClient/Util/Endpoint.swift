//
//  Endpoint.swift
//  APIClient
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

import Foundation

public protocol Endpoint {
    associatedtype RequestBody = Empty
    associatedtype ResponseBody = Empty

    var path: String { get }
    var method: HTTP.Method { get }
    var queryItems: [URLQueryItem] { get }
    var httpHeaders: [(name: String, value: String)] { get }

    func serializeBody(_ body: RequestBody, into request: inout URLRequest) throws
    func deserializeBody(_ data: Data) throws -> ResponseBody
}

public extension Endpoint {
    var method: HTTP.Method { .GET }

    var queryItems: [URLQueryItem] { [] }

    var httpHeaders: [(name: String, value: String)] {
        [(name: HTTP.HeaderName.accept.rawValue, value: HTTP.MIMEType.json)]
    }

    func serializeBody(_ body: RequestBody, into request: inout URLRequest) throws {}

    func deserializeBody(_ data: Data) throws -> ResponseBody where ResponseBody: Decodable {
        try JSONDecoder().decode(ResponseBody.self, from: data)
    }

    func request(baseUrl: URL, body: RequestBody) throws -> URLRequest {
        var components = URLComponents()
        components.path = path
        components.queryItems = queryItems.isEmpty ? nil : queryItems

        guard let url = components.url(relativeTo: baseUrl) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url.absoluteURL)
        request.httpMethod = method.rawValue
        httpHeaders.forEach { request.setHeader($0.name, value: $0.value) }
        try serializeBody(body, into: &request)

        return request
    }
}
