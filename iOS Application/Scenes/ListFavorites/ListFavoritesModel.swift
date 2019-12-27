//
//  ShowArticleModel.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-24.
//

import Combine
import NewsCore

class ListFavoritesModel: ModelType, ObservableObject {
    @Published var favorites: [Article]
    
    init(articles: [Article]) {
        self.favorites = articles
    }
}
