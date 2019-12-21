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
            // Views use this to dispatch actions to the reducer
            action: ListArticlesActionCreator(
                articleProvider: core.dependency(),
                dispatch: action(to: ListArticlesReducer())
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
            action: ShowArticleActionCreator(
                favoriteProvider: core.dependency(),
                dispatch: action(to: ShowArticleReducer())
            )
        )
    }
}

extension SceneRender {
    
    func listFavorites() -> some View {
        ListFavoritesView(
            model: ListFavoritesModel(parent: state),
            action: ListFavoritesActionCreator(
                favoriteProvider: core.dependency(),
                dispatch: action(to: ListFavoritesReducer())
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
    
    /// Creates action closure for the view to send to the reducer. This separation decouples actions and reducers.
    func action<Action, Reducer>(to reducer: Reducer) -> (Action) -> Void
        where Reducer: ReducerType, Reducer.Action == Action {
            return { action in
                // Allow middleware to passively execute against action
                self.middleware.forEach { $0.execute(on: action) }
                
                // Mutate the state for the action
                reducer.reduce(self.state, action)
            }
    }
}
