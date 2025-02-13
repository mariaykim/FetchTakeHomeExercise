//
//  NetworkManager.swift
//  FetchTakeHomeExercise
//
//  Created by Maria Kim on 2/13/25.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchRecipes() async throws -> [Recipe]
}

final class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    private let baseUrlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    
    private init() {}
    
    func fetchRecipes() async throws -> [Recipe] {
        guard let url = URL(string: baseUrlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let result = try JSONDecoder().decode(RecipesResponseModel.self, from: data)
        return result.recipes
    }
}
