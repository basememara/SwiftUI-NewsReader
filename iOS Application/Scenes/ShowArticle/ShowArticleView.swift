//
//  ListArticlesView.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-20.
//

import SwiftUI
import NewsCore

struct ShowArticleView: View {
    @ObservedObject var state: ShowArticleState
    
    let action: ShowArticleAction
    
    var body: some View {
        Text(state.article.title)
            .navigationBarTitle(Text("Favorites"))
            .navigationBarItems(trailing:
                Button(action: { self.action.toggleFavorite(id: self.state.article.id) }) {
                    Text(state.isFavorite ? "Unfavorite" : "Favorite").font(.body)
                }
            )
    }
}
