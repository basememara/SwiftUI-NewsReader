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

// MARK: - Dispatcher

extension ShowArticleReducer {
    
    func reduce(into store: AppStore, _ action: ShowArticleAction) {
        switch action {
        case .toggleFavorite(let id):
            toggleFavorite(id: id) { $0(store) }
        }
    }
}

// MARK: - Logic

private extension ShowArticleReducer {
    
    func toggleFavorite(id: String, mutate store: @escaping MutateStoreFunction) {
        favoriteWorker.toggleArticle(id: id)
        
        favoriteWorker.fetchArticles {
            guard case .success(let value) = $0 else {
                // TODO: Handle error
                return
            }
            
            // Mutate store since now complete
            store {
                $0.favorites = value
            }
        }
    }
}
