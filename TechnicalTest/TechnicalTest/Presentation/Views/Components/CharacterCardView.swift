//
//  CharacterCardView.swift
//  TechnicalTest
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

import SwiftUI
import APIClient

struct CharacterCardView: View {
    let character: Character

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.3))
                    .overlay(
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    )
            }
            .frame(height: 150)
            .clipped()

            VStack(alignment: .leading, spacing: 4) {
                Text(character.name)
                    .font(.headline)
                    .foregroundColor(.black)
                    .lineLimit(1)

                HStack {
                    StatusIndicator(status: character.status)
                    Text(character.status.rawValue)
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Text(character.species)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
        }
        .background(Color(.lightGray).opacity(0.1))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

private struct StatusIndicator: View {
    let status: CharacterStatus

    private var color: Color {
        switch status {
        case .alive:
            .green
        case .dead:
            .red
        case .unknown:
            .gray
        }
    }

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 8, height: 8)
    }
}

#Preview {
    CharacterCardView(
        character: Character(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: LocationReference(name: "Earth", url: ""),
            location: LocationReference(name: "Earth", url: ""),
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            episode: [],
            url: "",
            created: ""
        )
    )
    .frame(width: 180)
    .padding()
}
