//
//  ShowArticleState.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-24.
//

import NewsCore
import Combine

class ListFavoritesState: StateType, ObservableObject {
    @Published private(set) var favorites: [Article]
    
    private var cancellable = Set<AnyCancellable>()
    
    init(from state: AppState) {
        self.favorites = state.articles
            .filter { state.favorites.contains($0.id) }
        
        // TODO: Optimize lookup
        state.$favorites
            .map { value in
                value.compactMap { article in
                    state.articles.first { $0.id == article }
                }
            }
            .assign(to: \Self.favorites, on: self)
            .store(in: &cancellable)
    }
}
