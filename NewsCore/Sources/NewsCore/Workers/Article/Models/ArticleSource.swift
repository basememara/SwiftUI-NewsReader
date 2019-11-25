//
//  ArticleSource.swift
//  NewsCore
//
//  Created by Basem Emara on 2019-11-17.
//

import Foundation

public struct ArticleSource: Codable, Identifiable {
    public let id: String?
    public let name: String
    
    // MARK: - Initializers
    
    public init(id: String?, name: String) {
        self.id = id
        self.name = name
    }
}
