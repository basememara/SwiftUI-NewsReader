//
//  ShowArticleModel.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-24.
//

import Foundation
import Combine
import NewsCore

class ShowArticleModel: ModelType, ObservableObject {
    // Immutable from the view (updates from the top state only)
    @Published var article: Article
    @Published var isFavorite: Bool
    
    init(article: Article, isFavorite: Bool) {
        self.article = article
        self.isFavorite = isFavorite
    }
}
