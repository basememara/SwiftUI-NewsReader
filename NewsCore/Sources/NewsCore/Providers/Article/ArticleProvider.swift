//
//  ArticleWProvider.swift
//  NewsCore
//
//  Created by Basem Emara on 2019-11-13.
//

import Foundation

public struct ArticleProvider: ArticleProviderType {
    private let store: ArticleCache
    private let dataProvider: DataProviderType
    
    public init(store: ArticleCache, dataProvider: DataProviderType) {
        self.store = store
        self.dataProvider = dataProvider
    }
}

public extension ArticleProvider {
    
    func fetch(with request: ArticleAPI.FetchRequest, completion: @escaping (Result<[Article], DataError>) -> Void) {
        let cacheRequest = ArticleAPI.CacheRequest()
        
        store.fetch(with: cacheRequest) {
            // Immediately return local response
            completion($0)
            
            guard case .success = $0 else { return }
            
            // Sync remote updates to cache if applicable
            self.dataProvider.pull {
                // Validate if any updates that needs to be stored
                guard case .success(let value) = $0, !value.articles.isEmpty else { return }
                self.store.fetch(with: cacheRequest, completion: completion)
            }
        }
    }
}

public extension ArticleProvider {
    
    func fetch(url: String, completion: @escaping (Result<Article, DataError>) -> Void) {
        store.fetch(url: url) { result in
            // Retrieve missing cache data from cloud if applicable
            if case .nonExistent? = result.error {
                // Sync remote updates to cache if applicable
                self.dataProvider.pull {
                    // Validate if any updates that needs to be stored
                    guard case .success(let value) = $0, value.articles.contains(where: { $0.url == url }) else {
                        completion(result)
                        return
                    }
                    
                    self.store.fetch(url: url, completion: completion)
                }
                
                return
            }
            
            completion(result)
            
            // Pull again and compare if server mutations are expected
        }
    }
}
