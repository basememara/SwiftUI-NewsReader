//
//  File.swift
//  
//
//  Created by Basem Emara on 2019-11-13.
//

import Foundation

/// Post request namespace
public enum ArticleAPI {}

public protocol ArticleWorkerType {
    func fetch(with request: ArticleAPI.FetchRequest, completion: @escaping (Result<[Article], DataError>) -> Void)
    func fetch(url: String, completion: @escaping (Result<Article, DataError>) -> Void)
}

public protocol ArticleCache {
    func fetch(with request: ArticleAPI.CacheRequest, completion: @escaping (Result<[Article], DataError>) -> Void)
    func fetch(url: String, completion: @escaping (Result<Article, DataError>) -> Void)
    func createOrUpdate(_ request: Article, completion: @escaping (Result<Article, DataError>) -> Void)
}

public protocol ArticleRemote {
    func fetch(with request: ArticleAPI.RemoteRequest, completion: @escaping (Result<[Article], DataError>) -> Void)
}

// MARK: - Requests/Responses

public extension ArticleAPI {
    
    struct FetchRequest {
        public init() {}
    }
}

public extension ArticleAPI {
    
    struct CacheRequest {
        public init() {}
    }
}

public extension ArticleAPI {
    
    struct RemoteRequest {
        let type: RemoteType
        let query: QueryScope?
        let sources: [String]?
        let pageSize: Int?
        let pageIndex: Int?
        
        public init(
            type: RemoteType,
            query: QueryScope? = nil,
            sources: [String]? = nil,
            pageSize: Int? = nil,
            pageIndex: Int? = nil
        ) {
            self.type = type
            self.query = query
            self.sources = sources
            self.pageSize = pageSize
            self.pageIndex = pageIndex
        }
    }
    
    enum RemoteType {
        case all(
            from: Date? = nil,
            to: Date? = nil,
            language: String? = nil
        )
        
        case headlines(
            category: RemoteCategory? = nil,
            country: String? = nil
        )
    }
    
    enum RemoteCategory: String, CaseIterable {
        case business
        case entertainment
        case general
        case health
        case science
        case sports
        case technology
    }
    
    enum QueryScope {
        case all(String)
        case title(String)
    }
}
