//
//  MockNetworkManager.swift
//  FetchTakeHomeExercise
//
//  Created by Maria Kim on 2/13/25.
//

import Foundation
@testable import FetchTakeHomeExercise

class MockNetworkManager: NetworkManagerProtocol {
    static let shared = MockNetworkManager()
    
    private init() { }
    
    func fetchRecipes() async throws -> [Recipe] {
        guard let jsonUrl = Bundle.main.url(forResource: "ValidJSONResponse", withExtension: "json") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: jsonUrl)
        
        let result = try JSONDecoder().decode(RecipesResponseModel.self, from: data)
        return result.recipes
    }
    
    func fetchEmptyRecipes() async throws -> [Recipe] {
        let jsonString = """
        {
            "recipes": []
        }
        """
        let jsonData = jsonString.data(using: .utf8)!
        
        // Decode JSON data directly
        let result = try JSONDecoder().decode(RecipesResponseModel.self, from: jsonData)
        return result.recipes
    }
    
    func fetchInvalidRecipes() async throws -> [Recipe] {
        guard let jsonUrl = Bundle.main.url(forResource: "InvalidJSONResponse", withExtension: "json") else {
            throw URLError(.badServerResponse)
        }
        
        let (data, _) = try await URLSession.shared.data(from: jsonUrl)
        
        let result = try JSONDecoder().decode(RecipesResponseModel.self, from: data)
        return result.recipes
    }
}
