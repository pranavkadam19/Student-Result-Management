//
//  URLImage.swift
//  Thirani
//
//  Created by indianrenters on 27/06/25.
//

import SwiftUI

struct URLImage: View {
    @State private var uiImage: UIImage?
    let url: URL?
    
    var body: some View {
        Group {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            } else {
                
                ProgressView()
                    .frame(width: 100, height: 100)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
            }
        }
        .task {
            await loadImage()
        }
    }
    
    private func loadImage() async {
        guard let url = url else {
            // Optionally handle invalid URL case
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Validate HTTP response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response from server")
                return
            }
            
            // Create UIImage from data
            if let image = UIImage(data: data) {
                await MainActor.run {
                    self.uiImage = image
                }
            }
        } catch {
            print("Error loading image: \(error.localizedDescription)")
        }
    }
}

#Preview {
    URLImage(url: URL(string: "https://lh3.googleusercontent.com/a/ACg8ocKLdY8KFf8I-C-kAgBEwKXIfg2SnMjiUSSdwzR9KlLez5M9mbRg=s96-c"))
}
