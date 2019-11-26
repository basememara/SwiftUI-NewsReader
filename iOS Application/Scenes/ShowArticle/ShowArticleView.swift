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
    
    let dispatch: Dispatcher<ShowArticleAction>
    
    var body: some View {
        Text(state.article.title)
            .navigationBarTitle(Text("Article"))
            .navigationBarItems(trailing:
                Button(action: { self.dispatch(.toggleFavorite(id: self.state.article.id)) }) {
                    Text(state.isFavorite ? "Unfavorite" : "Favorite").font(.body)
                }
            )
    }
}

#if DEBUG
struct ShowArticleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ShowArticleView(
                state: ShowArticleState(
                    article: Article(
                        url: "http://example.com/1",
                        title: "Example article 1",
                        content: "This is a test content for 1.",
                        excerpt: "This is a test excecrpt",
                        image: nil,
                        author: nil,
                        publishedAt: Date(),
                        source: ArticleSource(
                            id: "google-news",
                            name: "Google News"
                        )
                    ),
                    isFavorite: false
                ),
                dispatch: { _ in }
            )
        }
    }
}
#endif
