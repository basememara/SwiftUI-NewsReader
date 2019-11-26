//
//  SceneRender.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-21.
//

import NewsCore
import SwiftUI

/// Root composer used to construct all views.
struct SceneRender {
    private let core: NewsCore
    private let store: AppStore
    
    init(core: NewsCore, store: AppStore) {
        self.core = core
        self.store = store
    }
}

extension SceneRender {
    
    func launchMain() -> some View {
        LaunchMainView(
            // Expose only some of the composer by wrapping it
            render: LaunchMainRender(from: self)
        )
    }
}

extension SceneRender {
    
    func listArticles() -> some View {
        let reducer = ListArticlesReducer(
            articleWorker: core.dependency()
        )
        
        return ListArticlesView(
            // Expose only some of the store by wrapping it
            state: ListArticlesState(from: store),
            // Views use it to dispatch actions to the reducer
            dispatch: { action in // TODO: Extract to property wrapper
                // Instead of giving the entire store to views
                reducer.reduce(into: self.store, action)
            },
            render: ListArticlesRender(from: self)
        )
    }
}

extension SceneRender {
    
    func showArticle(_ model: Article) -> some View {
        let reducer = ShowArticleReducer(
            favoriteWorker: core.dependency()
        )
        
        return ShowArticleView(
            state: ShowArticleState(
                from: store,
                model: model,
                text: "Test string",
                date: Date(),
                quantity: 99,
                selection: "Value 1"
            ),
            dispatch: { action in
                reducer.reduce(into: self.store, action)
            }
        )
    }
}

extension SceneRender {
    
    func listFavorites() -> some View {
        let reducer = ListFavoritesReducer(
            favoriteWorker: core.dependency()
        )
        
        return ListFavoritesView(
            state: ListFavoritesState(from: store),
            dispatch: { action in
                reducer.reduce(into: self.store, action)
            }
        )
    }
}

extension SceneRender {
    
    func showProfile() -> some View {
        ShowProfileView()
    }
}

extension SceneRender {
    
    func showSettings() -> some View {
        ShowSettingsView()
    }
}

extension SceneRender {
    
    func fetch(for url: URL) -> some View {
        // TODO: Build better query, don't force unwrap
        showArticle(store.articles.first(where: { $0.url == url.absoluteString })!)
    }
}
