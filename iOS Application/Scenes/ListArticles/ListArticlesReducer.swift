//
//  ListArticlesReducer.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-24.
//

import NewsCore

struct ListArticlesReducer: ReducerType {
    private let articleProvider: ArticleProviderType
    
    init(articleProvider: ArticleProviderType) {
        self.articleProvider = articleProvider
    }
}

// MARK: - Dispatcher

extension ListArticlesReducer {
    
    func apply(_ store: AppStore, _ action: ListArticlesAction) {
        switch action {
        case .loadArticles:
            loadArticles { $0(store) }
        case .clearArticles:
            clearArticles { $0(store) }
        }
    }
}

// MARK: - Logic

private extension ListArticlesReducer {
    
    func loadArticles(mutate store: @escaping MutateStoreFunction) {
        articleProvider.fetch(with: .init()) {
            guard case .success(let value) = $0 else {
                // TODO: Handle error
                return
            }
            
            // Mutate store since now complete
            store {
                $0.articles = value
            }
        }
    }
}

private extension ListArticlesReducer {
    
    func clearArticles(mutate store: @escaping MutateStoreFunction) {
        store {
            $0.articles = []
        }
    }
}
