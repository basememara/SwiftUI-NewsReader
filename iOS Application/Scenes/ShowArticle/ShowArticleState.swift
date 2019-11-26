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
    // Immutable from the outside
    @Published private(set) var article: Article
    @Published private(set) var isFavorite: Bool
    
    // Mutable from the outside
    var text: String
    var date: Date
    var quantity: Int
    var selection: String
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Setup
    
    init(
        from store: AppStore,
        model: Article,
        text: String,
        date: Date,
        quantity: Int,
        selection: String
    ) {
        self.article = model
        self.isFavorite = store.favorites.contains(model.id)
        
        self.text = text
        self.date = date
        self.quantity = quantity
        self.selection = selection
        
        // One-way binding for unidirectional flow
        store.$favorites
            .map { $0.contains(model.id) }
            .assign(to: \Self.isFavorite, on: self)
            .store(in: &cancellable)
    }
    
    /// Non-reactive initializer for static state. Primarily used for previews and testing.
    init(
        model: Article,
        isFavorite: Bool,
        text: String,
        date: Date,
        quantity: Int,
        selection: String
    ) {
        self.article = model
        self.isFavorite = isFavorite
        self.text = text
        self.date = date
        self.quantity = quantity
        self.selection = selection
    }
}
