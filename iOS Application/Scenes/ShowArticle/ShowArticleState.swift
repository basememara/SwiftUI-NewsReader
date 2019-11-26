//
//  ShowArticleState.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-24.
//

import Foundation
import Combine
import NewsCore

class ShowArticleState: StateType, ObservableObject {
    // Immutable from the view (updates from the top store only)
    @Published private(set) var article: Article
    @Published private(set) var isFavorite: Bool
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Setup
    
    init(parent store: AppStore, model: Article) {
        self.article = model
        self.isFavorite = store.favorites.contains(model.id)
        
        // One-way binding for unidirectional flow
        store.$favorites
            .map { $0.contains(model.id) }
            .assign(to: \Self.isFavorite, on: self)
            .store(in: &cancellable)
    }
    
    /// Non-reactive initializer for static state. Primarily used for previews and testing.
    init(model: Article, isFavorite: Bool) {
        self.article = model
        self.isFavorite = isFavorite
    }
}
