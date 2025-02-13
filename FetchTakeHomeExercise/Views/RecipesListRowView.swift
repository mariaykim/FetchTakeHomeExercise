//
//  RecipesListRowView.swift
//  FetchTakeHomeExercise
//
//  Created by Maria Kim on 2/13/25.
//

import SwiftUI

struct RecipeListRowView: View {
    private let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    var body: some View {
        HStack(spacing: 0) {
            FetchAsyncImage(urlString: recipe.photoUrlSmall)
                .frame(width: 50, height: 50)
                .padding(.trailing, 10)
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
            }
            Spacer()
        }
    }
}

#Preview {
    RecipeListRowView(recipe: Recipe(id: "1", cuisine: "pad see ew", name: "Maria's", photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg"))
}
