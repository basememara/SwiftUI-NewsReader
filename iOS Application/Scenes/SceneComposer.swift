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
    private let dependency: NewsCoreDependency
    private let state: AppState
    
    init(dependency: NewsCoreDependency, state: AppState) {
        self.dependency = dependency
        self.state = state
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
        ListArticlesView(
            state: ListArticlesState(from: state),
            action: ListArticlesAction(
                on: state,
                articleWorker: dependency.resolve()
            ),
            composer: ListArticlesComposer(from: self)
        )
    }
    
    func showArticle(for article: Article) -> some View {
        ShowArticleView(
            state: ShowArticleState(
                from: state,
                for: article
            ),
            action: ShowArticleAction(
                on: state,
                favoriteWorker: dependency.resolve()
            )
        )
    }
}

extension SceneComposer {
    
    func listFavorites() -> some View {
        ListFavoritesView(
            state: ListFavoritesState(from: state),
            action: ListFavoritesAction(
                on: state,
                favoriteWorker: dependency.resolve()
            )
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
        showArticle(for: state.articles.first(where: { $0.url == url.absoluteString })!)
    }
}

#if DEBUG
extension PreviewProvider {
    
    /// Use for constructing previews.
    static var composer: SceneComposer {
        SceneComposer(
            dependency: AppDependency(),
            state: AppState()
        )
    }
}
#endif
