//
//  APIClient.swift
//  APIClient
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

import Foundation

public actor APIClient {
    private let baseUrl: URL = URL(string: "https://rickandmortyapi.com/api/")!
    private let session: URLSession

    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    public func request<E: Endpoint>(
        _ endpoint: E,
        body: E.RequestBody
    ) async throws -> E.ResponseBody {
        let request = try endpoint.request(baseUrl: baseUrl, body: body)
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.failed
        }

        return try handleResponse(httpResponse, data: data, endpoint: endpoint)
    }
}

private extension APIClient {
    func handleResponse<E: Endpoint>(
        _ response: HTTPURLResponse,
        data: Data,
        endpoint: E
    ) throws -> E.ResponseBody {
        switch response.statusCode {
        case 200..<300:
            try endpoint.deserializeBody(data)
        case 400..<500:
            throw APIError.client
        case 500..<600:
            throw APIError.server
        default:
            throw APIError.failed
        }
    }
}
