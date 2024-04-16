//
//  Router.swift
//  Image Loading Assignment
//
//  Created by Gourav Kumar on 16/04/24.
//

import Foundation

enum Router {
    
    case getPhotos(Int)
    
    
    var baseURL: URL {
        return URL(string: "https://api.unsplash.com/")!
    }
    
    var httpMethod: String {
        switch self {
        case .getPhotos:
            return "GET"
        }
    }
    
    var path: String {
        switch self {
        case .getPhotos:
            return "photos"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getPhotos(let page):
            return ["client_id": "QtTnX1ssO4aVCqxNSugfNWAqhOJxM-7FpH548D9Btfs", "page": page]
        }
    }

    func asURLRequest() -> URLRequest {
        var url = baseURL.appendingPathComponent(self.path)
        
        if httpMethod == "GET", let parameters = parameters {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            var queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
            components.queryItems = queryItems
            url = components.url!
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        return request
    }

}
