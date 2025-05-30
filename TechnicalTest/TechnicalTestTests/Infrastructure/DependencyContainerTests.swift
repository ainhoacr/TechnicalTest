import Testing
import Foundation
@testable import TechnicalTest
@testable import APIClient

@MainActor
@Suite("DependencyContainer Tests")
struct DependencyContainerTests {
    @Test("shared instance is singleton")
    func sharedInstanceIsSingleton() {
        let container1 = DependencyContainer.shared
        let container2 = DependencyContainer.shared

        #expect(container1 === container2)
    }

    @Test("makeCharacterListViewModel creates valid instance")
    func makeCharacterListViewModelCreatesValidInstance() {
        let container = DependencyContainer.shared
        let viewModel = container.makeCharacterListViewModel()

        #expect(type(of: viewModel) == CharacterListViewModel.self)
    }

    @Test("repositories are properly initialized")
    func repositoriesAreProperlyInitialized() {
        let container = DependencyContainer.shared

        #expect(type(of: container.getCharactersUseCase) == GetCharactersUseCase.self)
    }
}
