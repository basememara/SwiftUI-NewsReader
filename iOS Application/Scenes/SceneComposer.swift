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
    private let dependency: AppDependency
    private let state: AppState
    
    init(dependency: AppDependency, state: AppState) {
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
            state: ListArticlesState(
                from: state,
                with: ListArticlesReducer(
                    dependency: dependency,
                    state: state
                )
            ),
            composer: ListArticlesComposer(from: self)
        )
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
