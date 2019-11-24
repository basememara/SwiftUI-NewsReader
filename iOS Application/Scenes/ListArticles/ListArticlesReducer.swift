//
//  ListArticlesReducer.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-22.
//

import Foundation
import NewsCore

struct ListArticlesReducer: ReducerType {
    private var state: AppState
    private let articleWorker: ArticleWorkerType
    
    init(state: AppState, articleWorker: ArticleWorkerType) {
        self.state = state
        self.articleWorker = articleWorker
    }
}

extension ListArticlesReducer {
    
    func reduce(with action: ListArticlesAction) {
        switch action {
        case .loadArticles:
            articleWorker.fetch(with: .init()) {
                guard case .success(let value) = $0 else {
                     // TODO: Handle error
                    return
                }
                
                self.state.articles = value
            }
        case .clearArticles:
            state.articles = []
        }
    }
}
