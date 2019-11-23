//
//  SceneFactory.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-21.
//

import Foundation
import SwiftUI
import NewsCore

/// Use to construct views centrally.
class SceneComposer: ObservableObject {
    
}

extension SceneComposer {
    
    func launchMain() -> some View {
        LaunchMainView()
    }
}

extension SceneComposer {
    
    func listArticles(for articles: [Article]) -> some View {
        ListArticlesView(articles: articles)
    }
    
    func showArticle(for article: Article) -> some View {
        ShowArticleView(article: article)
    }
}

extension SceneComposer {
    
    func listFavorites() -> some View {
        ListFavoritesView()
    }
}

extension SceneComposer {
    
    func showProfile() -> some View {
        ShowProfileView()
    }
}

extension SceneComposer {
    
    func showSettings() -> some View {
        ShowSettingsView()
    }
}

extension SceneComposer {
    
    func fetch(for url: URL, with state: AppState) -> some View {
        // TODO: Build better query, don't force unwrap
        showArticle(for: state.articles.first(where: { $0.url == url.absoluteString })!)
    }
}
