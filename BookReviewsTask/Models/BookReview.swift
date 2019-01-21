//
//  BookReview.swift
//  BookReviewsTask
//
//  Created by Omar Aguilar on 1/16/19.
//  Copyright © 2019 Omar Aguilar. All rights reserved.
//

import Foundation

struct BookReview : Codable {
    let title : String
    let headline : String
    let publicationDate : String
    let multimedia : ReviewMultimedia
    let author : String
    let summary : String
    let link : ReviewLink
    
    enum CodingKeys: String, CodingKey {
        case title = "display_title"
        case headline
        case publicationDate = "publication_date"
        case multimedia
        case author = "byline"
        case summary = "summary_short"
        case link
    }
}

struct ReviewMultimedia : Codable {
    let src : String
}

struct ReviewLink : Codable {
    let url : String
}
