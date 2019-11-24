//
//  ListArticlesAction.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-22.
//

import NewsCore

struct ListArticlesAction: ActionType {
    private var state: AppState
    private let articleWorker: ArticleWorkerType
    
    init(on state: AppState, articleWorker: ArticleWorkerType) {
        self.state = state
        self.articleWorker = articleWorker
    }
}

extension ListArticlesAction {
    
    func loadArticles() {
        articleWorker.fetch(with: .init()) {
            guard case .success(let value) = $0 else {
                // TODO: Handle error
                return
            }
            
            self.state.articles = value
        }
    }
}

extension ListArticlesAction {
    
    func clearArticles() {
        state.articles = []
    }
}

// TODO: Why does this runtime crash with `EXC_BAD_ACCESS`
//extension AppState: ListArticlesReducerState {}
//protocol ListArticlesReducerState: class {
//    var articles: [Article] { get set }
//}
