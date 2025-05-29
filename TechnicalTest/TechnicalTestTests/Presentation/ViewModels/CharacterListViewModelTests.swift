import Testing
import Foundation
@testable import TechnicalTest
@testable import APIClient

@MainActor
@Suite("CharacterListViewModel Tests")
struct CharacterListViewModelTests {
    @Test("loadCharacters handles success correctly")
    func loadCharactersHandlesSuccessCorrectly() async throws {
        let mockUseCase = MockGetCharactersUseCase()
        let expectedCharacters = [
            Character(
                id: 1,
                name: "Rick",
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
        mockUseCase.charactersToReturn = expectedCharacters
        let viewModel = CharacterListViewModel(getCharactersUseCase: mockUseCase)

        await viewModel.loadCharacters()

        #expect(viewModel.isLoading == false)
        #expect(viewModel.hasError == false)
        #expect(viewModel.characters.count == 1)
        #expect(viewModel.characters[0].name == "Rick")
        #expect(viewModel.errorMessage == nil)
    }

    @Test("loadCharacters handles error correctly")
    func loadCharactersHandlesErrorCorrectly() async throws {
        let mockUseCase = MockGetCharactersUseCase()
        mockUseCase.shouldThrowError = true
        let viewModel = CharacterListViewModel(getCharactersUseCase: mockUseCase)

        await viewModel.loadCharacters()

        #expect(viewModel.isLoading == false)
        #expect(viewModel.hasError == true)
        #expect(viewModel.characters.isEmpty)
        #expect(viewModel.errorMessage != nil)
    }

    @Test("retryLoading calls loadCharacters again")
    func retryLoadingCallsLoadCharactersAgain() async throws {
        let mockUseCase = MockGetCharactersUseCase()
        mockUseCase.shouldThrowError = true
        let viewModel = CharacterListViewModel(getCharactersUseCase: mockUseCase)

        await viewModel.loadCharacters()
        #expect(viewModel.hasError == true)

        mockUseCase.shouldThrowError = false
        mockUseCase.charactersToReturn = [
            Character(
                id: 1,
                name: "Rick",
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

        await viewModel.retryLoading()

        #expect(viewModel.hasError == false)
        #expect(viewModel.characters.count == 1)
        #expect(mockUseCase.executeCallCount == 2)
    }

    @Test("loadCharacters shows client error message")
    func loadCharactersShowsClientErrorMessage() async throws {
        let mockUseCase = MockGetCharactersUseCase()
        mockUseCase.shouldThrowError = true
        mockUseCase.errorToThrow = APIError.client
        let viewModel = CharacterListViewModel(getCharactersUseCase: mockUseCase)

        await viewModel.loadCharacters()

        #expect(viewModel.hasError == true)
        #expect(viewModel.errorMessage == "Error en la solicitud. Por favor, inténtalo de nuevo.")
    }

    @Test("loadCharacters shows server error message")
    func loadCharactersShowsServerErrorMessage() async throws {
        let mockUseCase = MockGetCharactersUseCase()
        mockUseCase.shouldThrowError = true
        mockUseCase.errorToThrow = APIError.server
        let viewModel = CharacterListViewModel(getCharactersUseCase: mockUseCase)

        await viewModel.loadCharacters()

        #expect(viewModel.hasError == true)
        #expect(viewModel.errorMessage == "Error del servidor. Por favor, inténtalo más tarde.")
    }

    @Test("loadCharacters shows failed error message")
    func loadCharactersShowsFailedErrorMessage() async throws {
        let mockUseCase = MockGetCharactersUseCase()
        mockUseCase.shouldThrowError = true
        mockUseCase.errorToThrow = APIError.failed
        let viewModel = CharacterListViewModel(getCharactersUseCase: mockUseCase)

        await viewModel.loadCharacters()

        #expect(viewModel.hasError == true)
        #expect(viewModel.errorMessage == "La solicitud falló. Verifica tu conexión.")
    }

    @Test("loadCharacters shows unknown error message")
    func loadCharactersShowsUnknownErrorMessage() async throws {
        let mockUseCase = MockGetCharactersUseCase()
        mockUseCase.shouldThrowError = true
        struct UnknownError: Error {}
        mockUseCase.errorToThrow = UnknownError()
        let viewModel = CharacterListViewModel(getCharactersUseCase: mockUseCase)

        await viewModel.loadCharacters()

        #expect(viewModel.hasError == true)
        #expect(viewModel.errorMessage == "Ha ocurrido un error inesperado. Por favor, inténtalo de nuevo.")
    }
}
