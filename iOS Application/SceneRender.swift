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
        let model = state.listArticles
        
        return ListArticlesView(
            // Expose only some of the state by wrapping it
            model: model,
            // Views use this to dispatch actions to the reducer
            action: ListArticlesActionCreator(
                articleProvider: core.dependency(),
                dispatch: action(to: ListArticlesReducer(), with: model)
            ),
            // Expose only some of the scene render by wrapping it
            render: ListArticlesRender(parent: self)
        )
    }
}

extension SceneRender {
    
    func showArticle(id: String) -> some View {
        guard let article = state.listArticles.articles
            .first(where: { $0.id == id }) else {
                return ShowErrorView()
                    .eraseToAnyView()
        }
        
        let model = ShowArticleModel(
            article: article,
            isFavorite: state.listFavorites.favorites
                .contains { $0.id == id }
        )
        
        return ShowArticleView(
            model: model,
            text: "Test string",
            date: Date(),
            quantity: 99,
            selection: "Value 1",
            action: ShowArticleActionCreator(
                favoriteProvider: core.dependency(),
                dispatch: action(to: ShowArticleReducer(), with: model)
            )
        )
        .eraseToAnyView()
    }
}

extension SceneRender {
    
    func listFavorites() -> some View {
        let model = state.listFavorites
        
        return ListFavoritesView(
            model: model,
            action: ListFavoritesActionCreator(
                favoriteProvider: core.dependency(),
                dispatch: action(to: ListFavoritesReducer(), with: model)
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
        showArticle(id: state.listArticles.articles
            .first(where: { $0.url == url.absoluteString })!.id)
    }
}

// MARK: - Helpers

private extension SceneRender {
    
    /// Creates action closure for the view to send to the reducer. This separation decouples actions and reducers.
    func action<Action, Reducer, Model>(to reducer: Reducer, with model: Model) -> (Action) -> Void
        where Reducer: ReducerType, Reducer.Action == Action, Reducer.Model == Model {
            return { action in
                // Allow middleware to passively execute against action
                self.middleware.forEach { $0.execute(on: action) }
                
                // Mutate the state for the action
                reducer.reduce(self.state, action)
            }
    }
}
