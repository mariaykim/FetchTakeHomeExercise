//
//  ContentView.swift
//  FetchTakeHomeExercise
//
//  Created by Maria Kim on 2/13/25.
//

import SwiftUI

struct RecipesListView: View {
    @StateObject private var viewModel = RecipesListViewViewModel()
    
    var body: some View {
        NavigationView {
            List {
                switch viewModel.state {
                case .loading:
                    ProgressView("Loading recipes...")
                        .frame(maxWidth: .infinity)
                    
                case .success:
                    ForEach(viewModel.recipes) { recipe in
                        RecipeListRowView(recipe: recipe)
                    }
                    .listStyle(InsetListStyle())
                    
                case .empty:
                    Text("No recipes available.")
                    
                case .error:
                    Text("Oh no! Please try again later.")
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Recipes")
            .onAppear {
                Task {
                    await viewModel.fetchRecipes()
                }
            }
            .refreshable {
                await viewModel.fetchRecipes()
            }
        }
    }
}

#Preview {
    RecipesListView()
}
