//
//  ListArticlesView.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-20.
//

import SwiftUI
import NewsCore

struct ShowArticleView: View {
    @ObservedObject private(set) var model: ShowArticleModel
    
    let action: ShowArticleActionCreator?
    
    var body: some View {
        Text(model.article.content ?? "")
            .navigationBarTitle(Text(model.article.title))
            .navigationBarItems(trailing:
                Button(
                    action: { self.action?.toggleFavorite(id: self.model.article.id) }
                ) {
                    Text(model.isFavorite ? "Unfavorite" : "Favorite").font(.body)
                }
            )
    }
}

#if DEBUG
struct ShowArticleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ShowArticleView(
                model: ShowArticleModel(
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
                action: nil
            )
        }
    }
}
#endif
