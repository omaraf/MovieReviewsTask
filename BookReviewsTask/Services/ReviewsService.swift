//
//  ReviewsService.swift
//  BookReviewsTask
//
//  Created by Omar Aguilar on 1/16/19.
//  Copyright © 2019 Omar Aguilar. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

class ReviewsService {
    
    func fetchReviews(offset : Int? = 0,  completion: @escaping (([BookReview]?) -> (Void))) {

        let decoder = JSONDecoder()
        Alamofire
            .request(ReviewsAPI.getReviews(offset: offset))
            .responseDecodableObject(keyPath: "results",
                                     decoder: decoder) { (response: DataResponse<[BookReview]>) in
            if let reviews = response.result.value {
                completion(reviews)
            }
        }
    }
}
