//
//  CharacterDetailViewModel.swift
//  TechnicalTest
//
//  Created by Ainhoa Calviño Rodríguez on 1/6/25.
//

import SwiftUI
import APIClient

@Observable
final class CharacterDetailViewModel {
    let character: Character

    init(character: Character) {
        self.character = character
    }

    var imageURL: URL? {
        URL(string: character.image)
    }

    var name: String { character.name }
    var origin: String { character.origin.name }
    var location: String { character.location.name }
}
