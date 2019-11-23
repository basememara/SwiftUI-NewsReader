//
//  File.swift
//  
//
//  Created by Basem Emara on 2019-11-18.
//

import Foundation

public struct CorePayload {
    public let articles: [Article]
    
    init(articles: [Article] = []) {
        self.articles = articles
    }
}

public extension CorePayload {
    
    /// A Boolean value indicating whether the instance is empty.
    var isEmpty: Bool {
        articles.isEmpty
    }
}

// MARK: - For JSON decoding

extension CorePayload: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case articles
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.articles = try container.decode([Article].self, forKey: .articles)
    }
}
