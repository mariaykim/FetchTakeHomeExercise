//
//  FetchImageCacheManagerTests.swift
//  FetchTakeHomeExercise
//
//  Created by Maria Kim on 2/13/25.
//

import XCTest
@testable import FetchTakeHomeExercise

class FetchImageCacheManagerTests: XCTestCase {
    
    func testCacheImageAndRetrieve() {
        let cacheManager = FetchImageCacheManager.shared
        let testURL = URL(string: "https://www.fetchtakehome.com/testImage.png")!
        let testImage = UIImage(systemName: "photo")!
        
        cacheManager.cacheImage(testImage, for: testURL)
        let cachedImage = cacheManager.cachedImage(for: testURL)
        
        XCTAssertNotNil(cachedImage)
    }
    
    func testCacheMissReturnsNil() {
        let cacheManager = FetchImageCacheManager.shared
        let missingURL = URL(string: "https://www.fetchtakehome.com/missingImageTest.png")!
        
        let cachedImage = cacheManager.cachedImage(for: missingURL)
        
        XCTAssertNil(cachedImage)
    }

    func testCacheIgnoresCorruptData() {
        let cacheManager = FetchImageCacheManager.shared
        let corruptDataUrl = URL(string: "https://www.fetchtakehome.com/corruptImageTest.png")!
        
        let request = URLRequest(url: corruptDataUrl)
        let corruptData = Data([0x00, 0x03])
        let response = CachedURLResponse(response: URLResponse(), data: corruptData)
        
        cacheManager.cache.storeCachedResponse(response, for: request)
        let cachedImage = cacheManager.cachedImage(for: corruptDataUrl)
        
        XCTAssertNil(cachedImage)
    }

}
