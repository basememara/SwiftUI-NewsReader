//
//  ListArticlesAction.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-22.
//

import NewsCore

enum ListArticlesAction: ActionType {
    case loadArticles([Article])
    case clearArticles
}

// MARK: - Logic

struct ListArticlesActionCreator: ActionCreatorType {
    private let articleProvider: ArticleProviderType
    private let dispatch: (ListArticlesAction) -> Void
    
    init(
        articleProvider: ArticleProviderType,
        dispatch: @escaping (ListArticlesAction) -> Void
    ) {
        self.articleProvider = articleProvider
        self.dispatch = dispatch
    }
}

extension ListArticlesActionCreator {
    
    func fetchArticles() {
        articleProvider.fetch(with: .init()) {
            guard case .success(let value) = $0 else {
                // TODO: Handle error
                return
            }
            
            self.dispatch(.loadArticles(value))
        }
    }
}

extension ListArticlesActionCreator {
    
    func clearArticles() {
        dispatch(.clearArticles)
    }
}
