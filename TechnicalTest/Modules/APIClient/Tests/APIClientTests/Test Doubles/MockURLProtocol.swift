//
//  MockURLProtocol.swift
//  APIClient
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

import Foundation

actor MockURLProtocolState {
    var responseData: Data?
    var responseStatusCode: Int = 200
    var responseError: (any Error)?

    static let shared = MockURLProtocolState()

    func reset() {
        responseData = nil
        responseStatusCode = 200
        responseError = nil
    }

    func setSuccess(data: Data, statusCode: Int = 200) {
        self.responseData = data
        self.responseStatusCode = statusCode
        self.responseError = nil
    }

    func setError(_ error: any Error) {
        self.responseError = error
        self.responseData = nil
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
            let error = await MockURLProtocolState.shared.responseError

            if let error = error {
                client?.urlProtocol(self, didFailWithError: error)
                return
            }

            let statusCode = await MockURLProtocolState.shared.responseStatusCode
            let data = await MockURLProtocolState.shared.responseData

            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil
            )!

            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            }

            client?.urlProtocolDidFinishLoading(self)
        }
    }

    override func stopLoading() {}
}
