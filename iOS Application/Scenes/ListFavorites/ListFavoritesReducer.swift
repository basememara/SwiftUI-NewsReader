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

extension ListFavoritesReducer {
    
    func reduce(into state: AppState, _ action: ListFavoritesAction) {
        switch action {
        case .loadFavorites:
            loadFavorites { $0(state) }
        case .toggleFavorite(let id):
            toggleFavorite(id: id) { $0(state) }
        }
    }
}

private extension ListFavoritesReducer {
    
    func loadFavorites(mutate state: @escaping MutateStateFunction) {
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

private extension ListFavoritesReducer {
    
    func toggleFavorite(id: String, mutate state: @escaping MutateStateFunction) {
        favoriteWorker.toggleArticle(id: id)
        loadFavorites(mutate: state) // TODO: Optimize
    }
}
