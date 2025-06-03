import Testing
import Foundation
@testable import APIClient

@Suite("APIClientTests", .serialized)
struct APIClientTests {
    @Test
    func successfulRequestReturnsDecodedResponse() async throws {
        let contextID = "test-successfulRequest"
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let client = APIClient(session: session, contextID: contextID)

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
            context: contextID,
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
        let contextID = "clientErrorThrowsClientError"
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let client = APIClient(session: session, contextID: contextID)

        await MockURLProtocolState.shared.setSuccess(
            context: contextID,
            data: Data(),
            statusCode: 401
        )

        await #expect(throws: APIError.client) {
            try await client.request(
                CharacterEndpoints.GetAllCharacters(),
                body: Empty.empty
            )
        }
    }
    
    @Test
    func serverErrorThrowsServerError() async throws {
        let contextID = "serverErrorThrowsServerError"
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let client = APIClient(session: session, contextID: contextID)

        await MockURLProtocolState.shared.setSuccess(
            context: contextID,
            data: Data(),
            statusCode: 500
        )

        await #expect(throws: APIError.server) {
            try await client.request(
                CharacterEndpoints.GetAllCharacters(),
                body: Empty.empty
            )
        }
    }

    @Test
    func networkErrorThrowsNetworkError() async throws {
        let contextID = "networkErrorThrowsNetworkError"
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let client = APIClient(session: session, contextID: contextID)

        let networkError = URLError(.notConnectedToInternet)
        await MockURLProtocolState.shared.setError(
            context: contextID,
            error: networkError
        )

        await #expect(throws: URLError.self) {
            try await client.request(
                CharacterEndpoints.GetAllCharacters(),
                body: Empty.empty
            )
        }
    }

    @Test
    func unknownStatusCodeThrowsFailedError() async throws {
        let contextID = "unknownStatusCode"
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let client = APIClient(session: session, contextID: contextID)

        await MockURLProtocolState.shared.setSuccess(
            context: contextID,
            data: Data(),
            statusCode: 999
        )

        await #expect(throws: APIError.failed) {
            try await client.request(
                CharacterEndpoints.GetAllCharacters(),
                body: Empty.empty
            )
        }
    }
}
