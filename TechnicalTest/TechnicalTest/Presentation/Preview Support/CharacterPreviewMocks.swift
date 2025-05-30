//
//  CharacterPreviewMocks.swift
//  TechnicalTest
//
//  Created by Ainhoa Calviño Rodríguez on 1/6/25.
//

#if DEBUG
import APIClient

extension Character {
    static let preview: Character = Character(
        id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        origin: LocationReference(name: "Earth (C-137)", url: ""),
        location: LocationReference(name: "Citadel of Ricks", url: ""),
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: [],
        url: "",
        created: ""
    )

    static let previewList: [Character] = [
        .preview,
        Character(
            id: 2,
            name: "Morty Smith",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: LocationReference(name: "Earth", url: ""),
            location: LocationReference(name: "Citadel of Ricks", url: ""),
            image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
            episode: [],
            url: "",
            created: ""
        )
    ]
}
#endif
