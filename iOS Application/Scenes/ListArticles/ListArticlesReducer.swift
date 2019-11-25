//
//  ListArticlesReducer.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-24.
//

import NewsCore

struct ListArticlesReducer: ReducerType {
    private let articleWorker: ArticleWorkerType
    
    init(articleWorker: ArticleWorkerType) {
        self.articleWorker = articleWorker
    }
}

extension ListArticlesReducer {
    
    func reduce(into state: AppState, _ action: ListArticlesAction) {
        switch action {
        case .loadArticles:
            loadArticles { $0(state) }
        case .clearArticles:
            clearArticles { $0(state) }
        }
    }
}

private extension ListArticlesReducer {
    
    func loadArticles(mutate state: @escaping MutateStateFunction) {
        articleWorker.fetch(with: .init()) {
            guard case .success(let value) = $0 else {
                // TODO: Handle error
                return
            }
            
            // Mutate state since now complete
            state {
                $0.articles = value
            }
        }
    }
}

private extension ListArticlesReducer {
    
    func clearArticles(mutate state: @escaping MutateStateFunction) {
        state {
            $0.articles = []
        }
    }
}
