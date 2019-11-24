//
//  ShowArticleAction.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-24.
//

import NewsCore

struct ShowArticleAction: ActionType {
    private var state: AppState
    private let favoriteWorker: FavoriteWorkerType
    
    init(on state: AppState, favoriteWorker: FavoriteWorkerType) {
        self.state = state
        self.favoriteWorker = favoriteWorker
    }
}

extension ShowArticleAction {
    
    func toggleFavorite(id: String) {
        favoriteWorker.toggleArticle(id: id)
        
        favoriteWorker.fetchArticles {
            guard case .success(let value) = $0 else {
                // TODO: Handle error
                return
            }
            
            self.state.favorites = value
        }
    }
}
