//
//  FetchImageCacheManager.swift
//  FetchTakeHomeExercise
//
//  Created by Maria Kim on 2/13/25.
//

import SwiftUI

class FetchImageCacheManager {
    static let shared = FetchImageCacheManager()
    
    let cache = URLCache(memoryCapacity: 50_000_000, diskCapacity: 100_000_000, diskPath: "fetchImageCache")
    
    func cachedImage(for url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data {
            if let image = UIImage(data: data) {
                if image.size.width > 0 && image.size.height > 0 {
                    return image
                } else {
                    cache.removeCachedResponse(for: request)
                }
            }
        }
        return nil
    }

    func cacheImage(_ image: UIImage, for url: URL) {
        let request = URLRequest(url: url)
        if let data = image.pngData() {
            if let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) {
                let cachedResponse = CachedURLResponse(response: response, data: data)
                cache.storeCachedResponse(cachedResponse, for: request)
            }
        }
    }
}
