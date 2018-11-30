//
//  Article.swift
//  NewsApp
//
//  Created by Burak.Ceylan on 27.11.18.
//  Copyright © 2018 Burak.Ceylan. All rights reserved.
//

import Foundation


struct NewsResponse: Codable {
    let totalResults: Int
    let articles: [NewsArticle]
}

struct NewsArticle: Codable {
    let author: String?
    let title: String?
    let describtion: String?
    let content: String?
    let urlToImage: String?
    var bookmarked: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case author
        case title
        case describtion
        case content
        case urlToImage
    }
}
