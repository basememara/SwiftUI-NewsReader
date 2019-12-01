//
//  ListArticlesDispatch.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-30.
//

import NewsCore

struct ListArticlesDispatch: DispatchType {
    private let articleProvider: ArticleProviderType
    private let reducer: (ListArticlesAction) -> Void
    
    init(
        articleProvider: ArticleProviderType,
        reducer: @escaping (ListArticlesAction) -> Void
    ) {
        self.articleProvider = articleProvider
        self.reducer = reducer
    }
}

// MARK: - Logic

extension ListArticlesDispatch {
    
    func fetchArticles() {
        articleProvider.fetch(with: .init()) {
            guard case .success(let value) = $0 else {
                // TODO: Handle error
                return
            }
            
            self.reducer(.loadArticles(value))
        }
    }
}

extension ListArticlesDispatch {
    
    func clearArticles() {
        reducer(.clearArticles)
    }
}
