//
//  ImageService.swift
//  Image Loading Assignment
//
//  Created by Gourav Kumar on 16/04/24.
//

import Foundation

typealias ImageResponse = (images: [ImageData], error: String?)
protocol ImageServiceProtocol {
    func getImages(router: Router) async throws -> ImageResponse
}

struct ImageService: ImageServiceProtocol {
    func getImages(router: Router) async throws -> ImageResponse {
        let request = router.asURLRequest()
        let (data, response) = try await URLSession.shared.data(for: request)
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            let model = try JSONDecoder().decode([ImageData].self, from: data)
            return (model, nil)
        } catch {
            if let error = String(data: data, encoding: .utf8) {
                return ([], error)
            } else {
                return ([], error.localizedDescription)
            }
        }
    }
}
