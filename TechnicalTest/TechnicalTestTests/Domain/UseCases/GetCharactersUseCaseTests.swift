import Testing
import Foundation
@testable import TechnicalTest
@testable import APIClient

@Suite("GetCharactersUseCase Tests")
struct GetCharactersUseCaseTests {
    @Test("execute returns characters from repository")
    func executeReturnsCharactersFromRepository() async throws {
        let mockRepository = MockCharacterRepository()
        let expectedCharacters = [
            Character(
                id: 1,
                name: "Rick",
                status: "alive",
                species: "Human",
                type: "",
                gender: "Male",
                origin: LocationReference(name: "Earth", url: ""),
                location: LocationReference(
                    name: "Earth",
                    url: ""
                ),
                image: "url",
                episode: [],
                url: "",
                created: ""
            ),
            Character(
                id: 2,
                name: "Morty",
                status: "alive",
                species: "Human",
                type: "",
                gender: "Male",
                origin: LocationReference(name: "Earth", url: ""),
                location: LocationReference(name: "Earth", url: ""),
                image: "url",
                episode: [],
                url: "",
                created: ""
            )
        ]
        mockRepository.charactersToReturn = expectedCharacters
        let useCase = GetCharactersUseCase(repository: mockRepository)

        let result = try await useCase.execute()

        #expect(result.count == 2)
        #expect(result[0].name == "Rick")
        #expect(result[1].name == "Morty")
        #expect(mockRepository.fetchAllCharactersCalled == true)
    }

    @Test("execute throws error when repository fails")
    func executeThrowsErrorWhenRepositoryFails() async throws {
        let mockRepository = MockCharacterRepository()
        mockRepository.shouldThrowError = true
        let useCase = GetCharactersUseCase(repository: mockRepository)

        do {
            _ = try await useCase.execute()
            Issue.record("Expected error to be thrown")
        } catch {
            #expect(error != nil)
        }
    }
}
