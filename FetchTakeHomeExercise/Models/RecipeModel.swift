//
//  RecipeModel.swift
//  FetchTakeHomeExercise
//
//  Created by Maria Kim on 2/13/25.
//

struct Recipe: Codable, Identifiable {
    let id: String
    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    let youtubeUrl: String?
    
    init(
        id: String,
        cuisine: String,
        name: String,
        photoUrlLarge: String? = nil,
        photoUrlSmall: String? = nil,
        sourceUrl: String? = nil,
        youtubeUrl: String? = nil
    ) {
        self.id = id
        self.cuisine = cuisine
        self.name = name
        self.photoUrlLarge = photoUrlLarge
        self.photoUrlSmall = photoUrlSmall
        self.sourceUrl = sourceUrl
        self.youtubeUrl = youtubeUrl
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
}
