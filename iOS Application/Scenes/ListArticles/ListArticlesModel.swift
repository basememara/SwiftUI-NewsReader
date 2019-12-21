//
//  ListArticlesModel.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-22.
//

import Combine
import NewsCore

/// Sub-state instead of exposing entire root state to view.
class ListArticlesModel: ModelType, ObservableObject {
    @Published var articles: [Article]
    
    init(articles: [Article]) {
        self.articles = articles
    }
}
