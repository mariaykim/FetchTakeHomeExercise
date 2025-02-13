//
//  NetworkManagerTests.swift
//  FetchTakeHomeExercise
//
//  Created by Maria Kim on 2/13/25.
//

import XCTest
@testable import FetchTakeHomeExercise

class NetworkManagerTests: XCTestCase {
    
    func testFetchRecipes_Success() async throws {
        let recipes = try await MockNetworkManager.shared.fetchRecipes()
        XCTAssertGreaterThan(recipes.count, 0)
    }
    
    func testFetchRecipes_Invalid() async throws {
        do {
            let _ = try await MockNetworkManager.shared.fetchInvalidRecipes()
            XCTFail("Expected error to be thrown")
        } catch let error as URLError {
            XCTAssertEqual(error.code, .badServerResponse, "Error should be a bad server response.")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testFetchRecipes_Empty() async throws {
        let recipes = try await MockNetworkManager.shared.fetchEmptyRecipes()
        XCTAssertTrue(recipes.isEmpty)
    }

}

