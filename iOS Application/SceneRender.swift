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
    private let state: AppState
    private let middleware: [MiddlewareType]
    
    init(core: NewsCore, state: AppState, middleware: [MiddlewareType]) {
        self.core = core
        self.state = state
        self.middleware = middleware
    }
}

// MARK: - Scenes

extension SceneRender {
    
    func launchMain() -> some View {
        LaunchMainView(
            // Expose only some of the composer by wrapping it
            render: LaunchMainRender(parent: self)
        )
    }
}

extension SceneRender {
    
    func listArticles() -> some View {
        ListArticlesView(
            // Expose only some of the state by wrapping it
            model: ListArticlesModel(parent: state),
            // Views uses it to dispatch actions to the reducer
            dispatch: ListArticlesDispatch(
                articleProvider: core.dependency(),
                reducer: make(from: ListArticlesReducer())
            ),
            // Expose only some of the scene render by wrapping it
            render: ListArticlesRender(parent: self)
        )
    }
}

extension SceneRender {
    
    func showArticle(id: String) -> some View {
        ShowArticleView(
            model: ShowArticleModel(
                parent: state,
                id: id
            ),
            text: "Test string",
            date: Date(),
            quantity: 99,
            selection: "Value 1",
            dispatch: ShowArticleDispatch(
                favoriteProvider: core.dependency(),
                reducer: make(from: ShowArticleReducer())
            )
        )
    }
}

extension SceneRender {
    
    func listFavorites() -> some View {
        ListFavoritesView(
            model: ListFavoritesModel(parent: state),
            dispatch: ListFavoritesDispatch(
                favoriteProvider: core.dependency(),
                reducer: make(from: ListFavoritesReducer())
            )
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
        showArticle(id: state.articles.first(where: { $0.url == url.absoluteString })!.id)
    }
}

// MARK: - Helpers

private extension SceneRender {
    
    func make<Action, Reducer>(from reducer: Reducer) -> Dispatcher<Action>
        where Reducer: ReducerType, Reducer.Action == Action {
            { action in
                // Allow middleware to passively execute against action
                self.middleware.forEach { $0.execute(on: action) }
                
                // Mutate the state for the action
                reducer.apply(self.state, action)
            }
    }
}
