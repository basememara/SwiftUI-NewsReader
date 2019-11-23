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
            guard state.articles.isEmpty else {
                state.articles = []
                return
            }
            
            let articleWorker: ArticleWorkerType = dependency.resolve()
            articleWorker.fetch(with: .init()) {
                guard case .success(let value) = $0 else { return }
                self.state.articles = value
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
                    guard !self.state.articles.isEmpty else { return }
                    self.state.articles.removeFirst()
                }
            }
        case .clearArticles:
            state.articles = []
        }
    }
}
