//
//  Article.swift
//  NewsCore
//
//  Created by Basem Emara on 2019-11-13.
//

import Foundation

public struct Article {
    public let url: String
    public let title: String
    public let content: String?
    public let excerpt: String?
    public let image: String?
    public let author: String?
    public let publishedAt: Date
    public let source: ArticleSource
}

extension Article: Identifiable {
    public var id: String { url }
}

// MARK: - JSON decoding

extension Article: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case url
        case title
        case content
        case excerpt = "description"
        case image = "urlToImage"
        case author
        case publishedAt
        case source
    }
}
