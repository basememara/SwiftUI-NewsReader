//
//  ShowArticleModel.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-12-27.
//

import Foundation
import Combine
import NewsCore

class ShowArticleModel: ModelType, ObservableObject {
    // Immutable from the view (updates from the top state only)
    @Published private(set) var article: Article
    @Published private(set) var isFavorite: Bool
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Setup
    
    /// Initializer for the article view.
    /// - Parameters:
    ///   - state: The global state of the application
    ///   - id: The identifier of the article. Only the identifier is
    ///         requested to help faciliate with deep link scenarios, etc.
    init(root state: AppState, id: String) {
        // TODO: Fix unwrapping by making optional and displaying error
        self.article = state.articles.first { $0.id == id }!
        
        self.isFavorite = state.favorites.contains(id)
        
        // One-way binding for unidirectional flow
        state.$favorites
            .map { $0.contains(id) }
            .assign(to: \Self.isFavorite, on: self)
            .store(in: &cancellable)
        
        // TODO: Bind to articles updates in case properties changes
    }
    
    /// Non-reactive initializer for static state. Primarily used for previews and testing.
    init(article: Article, isFavorite: Bool) {
        self.article = article
        self.isFavorite = isFavorite
    }
}
