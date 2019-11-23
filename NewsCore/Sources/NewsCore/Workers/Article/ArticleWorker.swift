//
//  ArticleWorker.swift
//  NewsCore
//
//  Created by Basem Emara on 2019-11-13.
//

import Foundation

public struct ArticleWorker: ArticleWorkerType {
    private let store: ArticleCache
    private let dataWorker: DataWorkerType
    
    public init(store: ArticleCache, dataWorker: DataWorkerType) {
        self.store = store
        self.dataWorker = dataWorker
    }
}

public extension ArticleWorker {
    
    func fetch(with request: ArticleAPI.FetchRequest, completion: @escaping (Result<[Article], DataError>) -> Void) {
        let cacheRequest = ArticleAPI.CacheRequest()
        
        store.fetch(with: cacheRequest) {
            // Immediately return local response
            completion($0)
            
            guard case .success = $0 else { return }
            
            // Sync remote updates to cache if applicable
            self.dataWorker.pull {
                // Validate if any updates that needs to be stored
                guard case .success(let value) = $0, !value.articles.isEmpty else { return }
                self.store.fetch(with: cacheRequest, completion: completion)
            }
        }
    }
}

public extension ArticleWorker {
    
    func fetch(url: String, completion: @escaping (Result<Article, DataError>) -> Void) {
        store.fetch(url: url) { result in
            // Retrieve missing cache data from cloud if applicable
            if case .nonExistent? = result.error {
                // Sync remote updates to cache if applicable
                self.dataWorker.pull {
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
