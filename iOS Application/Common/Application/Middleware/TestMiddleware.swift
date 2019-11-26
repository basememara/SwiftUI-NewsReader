//
//  TestMiddleware.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-26.
//

struct TestMiddleware: MiddlewareType {
    
    func execute(on action: ActionType) {
        switch action {
        case ListArticlesAction.loadArticles:
            print("Test middleware triggered on action 'loadArticles'.")
        case ShowArticleAction.toggleFavorite(let id):
            print("Test middleware triggered on action 'toggleFavorite(\(id))'.")
        case ListFavoritesAction.loadFavorites:
            print("Test middleware triggered on action 'loadFavorites'.")
        default:
            break
        }
    }
}
