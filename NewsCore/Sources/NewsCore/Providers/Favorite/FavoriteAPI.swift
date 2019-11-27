//
//  File 2.swift
//  
//
//  Created by Basem Emara on 2019-11-24.
//

import Foundation

/// Namespace
public enum FavoriteAPI {}

public protocol FavoriteProviderType {
    func fetchArticles(completion: @escaping (Result<[String], DataError>) -> Void)
    func addArticle(id: String)
    func removeArticle(id: String)
    func toggleArticle(id: String)
    func hasArticle(id: String) -> Bool
}

public protocol FavoriteStore {
    func fetchArticles(completion: @escaping (Result<[String], DataError>) -> Void)
    func addArticle(id: String)
    func removeArticle(id: String)
    func hasArticle(id: String) -> Bool
}
