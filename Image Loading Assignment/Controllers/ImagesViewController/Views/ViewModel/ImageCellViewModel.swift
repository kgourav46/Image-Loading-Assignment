//
//  ImageCellViewModel.swift
//  Image Loading Assignment
//
//  Created by Gourav Kumar on 16/04/24.
//

import Foundation

protocol ImageCellViewModelProtocol {
    init(image: ImageData)
    var url: URL? { get }
}

final class ImageCellViewModel: ImageCellViewModelProtocol {
    
    private let image: ImageData
    required init(image: ImageData) {
        self.image = image
    }
    
    var url: URL? {
        if let thumb = image.urls?.thumb {
            return URL(string: thumb)
        }
        return nil
    }
}
