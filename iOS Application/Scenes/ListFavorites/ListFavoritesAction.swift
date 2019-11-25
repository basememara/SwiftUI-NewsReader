//
//  ShowArticleAction.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-24.
//

import NewsCore

enum ListFavoritesAction: ActionType {
    case loadFavorites
    case toggleFavorite(id: String)
}
