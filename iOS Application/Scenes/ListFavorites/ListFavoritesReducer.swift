//
//  ListFavoritesReducer.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-25.
//

import NewsCore

struct ListFavoritesReducer: ReducerType {
    private let favoriteProvider: FavoriteProviderType
    
    init(favoriteProvider: FavoriteProviderType) {
        self.favoriteProvider = favoriteProvider
    }
}

// MARK: - Dispatcher

extension ListFavoritesReducer {
    
    func apply(_ state: AppState, _ action: ListFavoritesAction) {
        switch action {
        case .loadFavorites:
            loadFavorites { $0(state) }
        case .toggleFavorite(let id):
            toggleFavorite(id: id) { $0(state) }
        }
    }
}

// MARK: - Logic

private extension ListFavoritesReducer {
    
    func loadFavorites(mutate state: @escaping MutateStateFunction) {
        favoriteProvider.fetchArticles {
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
        favoriteProvider.toggleArticle(id: id)
        loadFavorites(mutate: state) // TODO: Optimize
    }
}
