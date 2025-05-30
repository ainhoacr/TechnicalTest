//
//  CharacterDetailView.swift
//  TechnicalTest
//
//  Created by Ainhoa Calviño Rodríguez on 1/6/25.
//

import SwiftUI
#if DEBUG
import APIClient
#endif

struct CharacterDetailView: View {
    let viewModel: CharacterDetailViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                if let url = viewModel.imageURL {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    } placeholder: {
                        Rectangle()
                            .foregroundColor(.gray.opacity(0.3))
                            .frame(height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(ProgressView())
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    InfoRow(label: "Origin", value: viewModel.origin)
                    InfoRow(label: "Location", value: viewModel.location)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
        }
        .navigationTitle(viewModel.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Reusable Row

private struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.system(size: 20))
                .foregroundColor(.black)
            Text(value)
                .font(.system(size: 16))
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    NavigationStack {
        CharacterDetailView(
            viewModel: CharacterDetailViewModel(
                character: Character.previewList.first!
            )
        )
    }
}
