//
//  MockURLProtocol.swift
//  APIClient
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

import Foundation

actor MockURLProtocolState {
    struct Entry {
        var data: Data?
        var statusCode: Int
        var error: Error?
    }

    private var entries: [String: Entry] = [:]
    static let shared = MockURLProtocolState()

    func setSuccess(context: String, data: Data, statusCode: Int = 200) {
        entries[context] = Entry(data: data, statusCode: statusCode, error: nil)
    }

    func setError(context: String, error: Error) {
        entries[context] = Entry(data: nil, statusCode: 0, error: error)
    }

    func getEntry(for context: String) -> Entry? {
        entries[context]
    }
}

final class MockURLProtocol: URLProtocol, @unchecked Sendable {
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        Task {
            let contextID = request.contextID ?? "default"
            guard let entry = await MockURLProtocolState.shared.getEntry(for: contextID) else {
                client?.urlProtocol(self, didFailWithError: URLError(.unknown))
                return
            }

            if let error = entry.error {
                client?.urlProtocol(self, didFailWithError: error)
                return
            }

            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: entry.statusCode,
                httpVersion: nil,
                headerFields: nil
            )!

            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

            if let data = entry.data {
                client?.urlProtocol(self, didLoad: data)
            }

            client?.urlProtocolDidFinishLoading(self)
        }
    }

    override func stopLoading() {}
}


extension URLRequest {
    private static let contextKey = "X-Test-Context-ID"

    var contextID: String? {
        get { value(forHTTPHeaderField: Self.contextKey) }
        set { setValue(newValue, forHTTPHeaderField: Self.contextKey) }
    }
}
