//
//  TechnicalTestApp.swift
//  TechnicalTest
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

import SwiftUI

@main
struct TechnicalTestApp: App {

    init() {
        _ = ImageCacheManager.shared
    }

    var body: some Scene {
        WindowGroup {
            CharacterListView(
                viewModel: DependencyContainer.shared.makeCharacterListViewModel()
            )
        }
    }
}
