//
//  ListArticlesView.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-20.
//

import SwiftUI
import NewsCore

struct ListFavoritesView: View {
    @ObservedObject var state: ListFavoritesState
    
    let action: ListFavoritesAction
    
    var body: some View {
        
        List {
            ForEach(state.favorites) { article in
                Text(article.title)
            }
            .onDelete {
                guard let index = $0.first,
                    let article = self.state.favorites[safe: index] else {
                        return
                }
                
                self.action.toggleFavorite(id: article.id)
            }
        }
        .navigationBarTitle(Text("Favorites"))
        .onAppear {
            self.action.loadFavorites()
        }
    }
}
