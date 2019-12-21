//
//  AppState.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-20.
//

import Combine
import NewsCore

/// Global state for the application.
///
/// Only update on main thread since views are observing changes.
class AppState: StateType, ObservableObject {
    var listArticles = ListArticlesModel(articles: [])
    
    var showArticle = ShowArticleModel(
        article: Article(
            url: "",
            title: "",
            content: nil,
            excerpt: nil,
            image: nil,
            author: nil,
            publishedAt: .distantPast,
            source: ArticleSource(id: nil, name: "")
        ),
        isFavorite: false
    )
    
    var listFavorites = ListFavoritesModel(articles: [])
}
