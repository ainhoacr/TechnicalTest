import Testing
import Foundation
@testable import APIClient

@Suite("APIClientTests", .serialized)
struct APIClientTests {
    @Test
    func successfulRequestReturnsDecodedResponse() async throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let client = APIClient(session: session)

        let json = """
        {
            "info": {
                "count": 1,
                "pages": 1,
                "next": null,
                "prev": null
            },
            "results": []
        }
        """
        
        await MockURLProtocolState.shared.setSuccess(
            data: json.data(using: .utf8)!,
            statusCode: 200
        )

        let result: CharacterListResponseDTO = try await client.request(
            CharacterEndpoints.GetAllCharacters(),
            body: Empty.empty
        )

        #expect(result.results.isEmpty)
    }

    @Test
    func clientErrorThrowsClientError() async throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let client = APIClient(session: session)

        await MockURLProtocolState.shared.setSuccess(
            data: Data(),
            statusCode: 401
        )

        await #expect(throws: APIError.client) {
            try await client.request(CharacterEndpoints.GetAllCharacters(), body: Empty.empty)
        }
    }
    
    @Test
    func serverErrorThrowsServerError() async throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let client = APIClient(session: session)

        await MockURLProtocolState.shared.setSuccess(
            data: Data(),
            statusCode: 500
        )

        await #expect(throws: APIError.server) {
            try await client.request(CharacterEndpoints.GetAllCharacters(), body: Empty.empty)
        }
    }

    @Test
    func networkErrorThrowsNetworkError() async throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let client = APIClient(session: session)

        let networkError = URLError(.notConnectedToInternet)
        await MockURLProtocolState.shared.setError(networkError)

        await #expect(throws: URLError.self) {
            try await client.request(CharacterEndpoints.GetAllCharacters(), body: Empty.empty)
        }
    }

    @Test
    func unknownStatusCodeThrowsFailedError() async throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let client = APIClient(session: session)

        await MockURLProtocolState.shared.setSuccess(
            data: Data(),
            statusCode: 999
        )

        await #expect(throws: APIError.failed) {
            try await client.request(CharacterEndpoints.GetAllCharacters(), body: Empty.empty)
        }
    }
}
