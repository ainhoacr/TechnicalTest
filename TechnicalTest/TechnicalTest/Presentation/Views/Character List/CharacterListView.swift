//
//  CharacterListView.swift
//  TechnicalTest
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

//
//  CharacterListView.swift
//  TechnicalTest
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

import SwiftUI
import APIClient

struct CharacterListView: View {
    let viewModel: CharacterListViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    LoadingView()
                } else if viewModel.hasError {
                    ErrorView(
                        message: viewModel.errorMessage ?? "Error desconocido",
                        onRetry: {
                            Task {
                                await viewModel.retryLoading()
                            }
                        }
                    )
                } else {
                    CharacterGridView(characters: viewModel.characters)
                }
            }
            .navigationTitle("Rick & Morty")
            .task {
                await viewModel.loadCharacters()
            }
        }
    }
}

// MARK: - Subviews

private struct CharacterGridView: View {
    let characters: [Character]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                ForEach(characters) { character in
                    CharacterCardView(character: character)
                }
            }
            .padding()
        }
    }
}

private struct ErrorView: View {
    let message: String
    let onRetry: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.orange)
            
            Text(message)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Reintentar", action: onRetry)
                .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    CharacterListView(
        viewModel: CharacterListViewModel(
            getCharactersUseCase: GetCharactersUseCase(
                repository: CharacterRepositoryImpl(
                    apiClient: APIClient()
                )
            )
        )
    )
}
