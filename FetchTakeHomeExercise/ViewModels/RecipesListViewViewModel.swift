//
//  RecipesListViewViewModel.swift
//  FetchTakeHomeExercise
//
//  Created by Maria Kim on 2/13/25.
//

import Foundation

enum RecipeDataState {
    case loading
    case success
    case empty
    case error
}

@MainActor
final class RecipesListViewViewModel: ObservableObject {
    @Published var recipes = [Recipe]()
    @Published var state: RecipeDataState = .loading

    private let networkManager = NetworkManager.shared

    func fetchRecipes() async {
        do {
            let result = try await networkManager.fetchRecipes()
            if result.isEmpty {
                self.state = .empty
            } else {
                self.recipes = result
                self.state = .success
            }
        } catch {
            self.state = .error
        }
    }
}
