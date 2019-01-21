//
//  ReviewsAPI.swift
//  BookReviewsTask
//
//  Created by Omar Aguilar on 1/18/19.
//  Copyright © 2019 Omar Aguilar. All rights reserved.
//

import Foundation
import Alamofire

enum ReviewsAPI: APIConfiguration {
    
    case getReviews(offset:Int?)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getReviews:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .getReviews(_):
            return "/svc/movies/v2/reviews/dvd-picks.json"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .getReviews(let offset):
            return [K.APIParameterKey.offset: offset ?? 0, K.APIParameterKey.apiKey: K.ApiKey.getKey() ?? ""]
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.Server.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                switch self {
                    case .getReviews(_):
                        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
//                    default:
//                        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                }
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}

struct K {
    struct Server {
        static let baseURL = "https://api.nytimes.com"
    }
    
    struct APIParameterKey {
        static let offset = "offset"
        static let apiKey = "api-key"
    }
    
    struct ApiKey {
        
        static func getKey() -> String? {
            if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"), let nsDictionary = NSDictionary(contentsOfFile: path) {
                return nsDictionary["nytimes-api-key"] as? String ?? nil
            } else {
                return nil
            }
        }
    }
}
