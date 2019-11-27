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
    
    // MARK: - Initializers
    
    public init(
        url: String,
        title: String,
        content: String?,
        excerpt: String?,
        image: String?,
        author: String?,
        publishedAt: Date,
        source: ArticleSource
    ) {
        self.url = url
        self.title = title
        self.content = content
        self.excerpt = excerpt
        self.image = image
        self.author = author
        self.publishedAt = publishedAt
        self.source = source
    }
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
