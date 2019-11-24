//
//  ShowArticleState.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-24.
//

import NewsCore
import Combine

class ShowArticleState: StateType, ObservableObject {
    @Published var article: Article
    @Published var isFavorite: Bool
    
    private var cancellable = Set<AnyCancellable>()
    
    init(from state: AppState, for article: Article) {
        self.article = article
        self.isFavorite = state.favorites.contains(article.id)
        
        // Subscriptions
        state.$favorites
            .map { $0.contains(self.article.id) }
            .assign(to: \Self.isFavorite, on: self)
            .store(in: &cancellable)
    }
}
