//
//  UIImageView+Extension.swift
//  Image Loading Assignment
//
//  Created by Gourav Kumar on 16/04/24.
//

import UIKit

extension UIImageView {
    private static let imageCache = NSCache<NSString, UIImage>()
    
    func loadImage(from url: URL, placeholder: UIImage? = nil) {
        self.image = placeholder
        if let cachedImage = UIImageView.imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let newImage = UIImage(data: data) {
                    UIImageView.imageCache.setObject(newImage, forKey: url.absoluteString as NSString)
                    await MainActor.run {
                        self.image = newImage
                    }
                }
            } catch {
                debugPrint(error)
            }
        }
    }
}
