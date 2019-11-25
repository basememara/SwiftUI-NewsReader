//
//  ShowArticleReducer.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-25.
//

import NewsCore

struct ShowArticleReducer: ReducerType {
    private let favoriteWorker: FavoriteWorkerType
    
    init(favoriteWorker: FavoriteWorkerType) {
        self.favoriteWorker = favoriteWorker
    }
}

extension ShowArticleReducer {
    
    func reduce(into state: AppState, _ action: ShowArticleAction) {
        switch action {
        case .toggleFavorite(let id):
            toggleFavorite(id: id) { $0(state) }
        }
    }
}

private extension ShowArticleReducer {
    
    func toggleFavorite(id: String, mutate state: @escaping MutateStateFunction) {
        favoriteWorker.toggleArticle(id: id)
        
        favoriteWorker.fetchArticles {
            guard case .success(let value) = $0 else {
                // TODO: Handle error
                return
            }
            
            // Mutate state since now complete
            state {
                $0.favorites = value
            }
        }
    }
}
