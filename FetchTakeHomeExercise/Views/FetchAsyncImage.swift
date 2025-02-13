//
//  FetchAsyncImage.swift
//  FetchTakeHomeExercise
//
//  Created by Maria Kim on 2/13/25.
//

import SwiftUI

struct FetchAsyncImage: View {
    let urlString: String?
    
    @State private var image: UIImage?

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
                    .task {
                        await loadImage()
                    }
            }
        }
    }

    private func loadImage() async {
        guard let urlString = urlString,
                let url = URL(string: urlString)
        else {
            return
        }

        if let cachedImage = FetchImageCacheManager.shared.cachedImage(for: url) {
            await updateImage(cachedImage)
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            // Ensure valid HTTP response
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let downloadedImage = UIImage(data: data) {
                    FetchImageCacheManager.shared.cacheImage(downloadedImage, for: url)
                    
                    await updateImage(downloadedImage)
                }
            }
        } catch {
            print("Failed to load image: \(error.localizedDescription)")
        }
    }

    @MainActor
    private func updateImage(_ newImage: UIImage) {
        self.image = newImage
    }

}
