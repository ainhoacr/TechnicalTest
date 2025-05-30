//
//  ImageCacheManager.swift
//  TechnicalTest
//
//  Created by Ainhoa Calviño Rodríguez on 29/5/25.
//

import Foundation

final class ImageCacheManager {
    static let shared = ImageCacheManager()

    private init() {
        setupURLCache()
    }
    private func setupURLCache() {
        let cache = URLCache(
            memoryCapacity: 50 * 1024 * 1024,    // 50MB
            diskCapacity: 200 * 1024 * 1024,     // 200MB
            diskPath: "images_cache"
        )
        URLCache.shared = cache
    }
}