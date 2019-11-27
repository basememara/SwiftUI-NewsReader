//
//  SeedNetworkStore.swift
//  NewsCore
//
//  Created by Basem Emara on 2019-11-18.
//

import Foundation

public struct RemoteNetworkStore: RemoteStore {
    private let articleRemote: ArticleRemote
    private let log: LogProviderType
    
    public init(articleRemote: ArticleRemote, log: LogProviderType) {
        self.articleRemote = articleRemote
        self.log = log
    }
}

public extension RemoteNetworkStore {
    
    func configure() {
        // No configure needed
    }
    
    func fetchLatest(after date: Date?, with request: DataAPI.RemoteRequest, completion: @escaping (Result<CorePayload, DataError>) -> Void) {
        let request = ArticleAPI.RemoteRequest(
            type: .all(from: date)
        )
        
        articleRemote.fetch(with: request) {
            guard case .success(let articles) = $0 else {
                self.log.error("An error occured while fetching the latest articles: \(String(describing: $0.error)).")
                completion(.failure($0.error ?? .unknownReason(nil)))
                return
            }
            
            let model = CorePayload(articles: articles)
            completion(.success(model))
        }
    }
}
