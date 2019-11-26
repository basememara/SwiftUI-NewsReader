//
//  ListFavoritesReducer.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-25.
//

import NewsCore

struct ListFavoritesReducer: ReducerType {
    private let favoriteWorker: FavoriteWorkerType
    
    init(favoriteWorker: FavoriteWorkerType) {
        self.favoriteWorker = favoriteWorker
    }
}

// MARK: - Dispatcher

extension ListFavoritesReducer {
    
    func apply(_ store: AppStore, _ action: ListFavoritesAction) {
        switch action {
        case .loadFavorites:
            loadFavorites { $0(store) }
        case .toggleFavorite(let id):
            toggleFavorite(id: id) { $0(store) }
        }
    }
}

// MARK: - Logic

private extension ListFavoritesReducer {
    
    func loadFavorites(mutate store: @escaping MutateStoreFunction) {
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

private extension ListFavoritesReducer {
    
    func toggleFavorite(id: String, mutate store: @escaping MutateStoreFunction) {
        favoriteWorker.toggleArticle(id: id)
        loadFavorites(mutate: store) // TODO: Optimize
    }
}
