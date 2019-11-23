//
//  ListArticlesReducer.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-22.
//

import Foundation
import NewsCore

struct ListArticlesReducer: ReducerType {
    private let dependency: AppDependency
    private var state: AppState
    
    init(dependency: AppDependency, state: AppState) {
        self.dependency = dependency
        self.state = state
    }
    
    func reduce(with action: ListArticlesAction) {
        switch action {
        case .loadArticles:
            // TODO: Temporary until better organization
            let articleWorker: ArticleWorkerType = dependency.resolve()
            articleWorker.fetch(with: .init()) {
                guard case .success(let value) = $0 else { return }
                self.state.articles = value
            }
        case .clearArticles:
            state.articles = []
        }
    }
}
