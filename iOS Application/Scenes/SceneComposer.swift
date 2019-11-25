//
//  SceneComposer.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-21.
//

import Foundation
import SwiftUI
import NewsCore

/// Use to construct views centrally.
struct SceneComposer {
    private let config: NewsCoreConfig
    private let store: AppStore
    
    init(config: NewsCoreConfig, store: AppStore) {
        self.config = config
        self.store = store
    }
}

extension SceneComposer {
    
    func launchMain() -> some View {
        LaunchMainView(
            composer: LaunchMainComposer(from: self)
        )
    }
}

extension SceneComposer {
    
    func listArticles() -> some View {
        let reducer = ListArticlesReducer(
            articleWorker: config.dependency()
        )
        
        return ListArticlesView(
            state: ListArticlesState(from: store),
            dispatch: { action in
                reducer.reduce(into: self.store, action)
            },
            composer: ListArticlesComposer(from: self)
        )
    }
}

extension SceneComposer {
    
    func showArticle(for article: Article) -> some View {
        let reducer = ShowArticleReducer(
            favoriteWorker: config.dependency()
        )
        
        return ShowArticleView(
            state: ShowArticleState(from: store, article: article),
            dispatch: { action in
                reducer.reduce(into: self.store, action)
            }
        )
    }
}

extension SceneComposer {
    
    func listFavorites() -> some View {
        let reducer = ListFavoritesReducer(
            favoriteWorker: config.dependency()
        )
        
        return ListFavoritesView(
            state: ListFavoritesState(from: store),
            dispatch: { action in
                reducer.reduce(into: self.store, action)
            }
        )
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
    
    func fetch(for url: URL) -> some View {
        // TODO: Build better query, don't force unwrap
        showArticle(for: store.articles.first(where: { $0.url == url.absoluteString })!)
    }
}
