//
//  ListFavoritesDispatch.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-30.
//

import NewsCore

struct ListFavoritesDispatch: DispatchType {
    private let favoriteProvider: FavoriteProviderType
    private let reducer: (ListFavoritesAction) -> Void
    
    init(
        favoriteProvider: FavoriteProviderType,
        reducer: @escaping (ListFavoritesAction) -> Void
    ) {
        self.favoriteProvider = favoriteProvider
        self.reducer = reducer
    }
}

// MARK: - Logic

extension ListFavoritesDispatch {
    
    func fetchFavorites() {
        favoriteProvider.fetchArticles {
            guard case .success(let value) = $0 else {
                // TODO: Handle error
                return
            }
            
            self.reducer(.loadFavorites(value))
        }
    }
}

extension ListFavoritesDispatch {
    
    func toggleFavorite(id: String) {
        favoriteProvider.toggleArticle(id: id)
        fetchFavorites() // TODO: Optimize
    }
}
