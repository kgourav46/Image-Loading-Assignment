//
//  ImagesModel.swift
//  Image Loading Assignment
//
//  Created by Gourav Kumar on 16/04/24.
//

import Foundation

struct ImageData: Decodable {
    let id, slug: String?
    let urls: ImageUrls?
    
    enum CodingKeys: String, CodingKey {
        case id, slug
        case urls
    }
}

struct ImageUrls: Decodable {
    let thumb: String?

    enum CodingKeys: String, CodingKey {
        case thumb
    }
}
