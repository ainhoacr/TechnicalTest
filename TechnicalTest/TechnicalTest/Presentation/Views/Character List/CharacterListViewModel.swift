//
//  CharacterListViewModel.swift
//  TechnicalTest
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

//
//  CharacterListViewModel.swift
//  TechnicalTest
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

import Foundation
import SwiftUI
import APIClient

@MainActor
@Observable
final class CharacterListViewModel {

    // MARK: - Published Properties
    private(set) var characters: [Character] = []
    private(set) var isLoading: Bool = false
    private(set) var errorMessage: String?
    private(set) var hasError: Bool = false

    // MARK: - Dependencies
    private let getCharactersUseCase: GetCharactersUseCaseProtocol

    // MARK: - Initialization
    init(getCharactersUseCase: GetCharactersUseCaseProtocol) {
        self.getCharactersUseCase = getCharactersUseCase
    }

    // MARK: - Public Methods
    func loadCharacters() async {
        isLoading = true
        hasError = false
        errorMessage = nil

        do {
            let fetchedCharacters = try await getCharactersUseCase.execute()
            characters = fetchedCharacters
        } catch {
            hasError = true
            errorMessage = mapErrorToUserMessage(error)
        }

        isLoading = false
    }

    func retryLoading() async {
        await loadCharacters()
    }
}

// MARK: - Private Methods

private extension CharacterListViewModel {
    func mapErrorToUserMessage(_ error: Error) -> String {
        switch error {
        case let apiError as APIError:
            switch apiError {
            case .client:
                "Error en la solicitud. Por favor, inténtalo de nuevo."
            case .server:
                "Error del servidor. Por favor, inténtalo más tarde."
            case .failed:
                "La solicitud falló. Verifica tu conexión."
            }
        default:
            "Ha ocurrido un error inesperado. Por favor, inténtalo de nuevo."
        }
    }
}
