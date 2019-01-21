//
//  APIConfiguration.swift
//  BookReviewsTask
//
//  Created by Omar Aguilar on 1/18/19.
//  Copyright © 2019 Omar Aguilar. All rights reserved.
//

import Foundation

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}
