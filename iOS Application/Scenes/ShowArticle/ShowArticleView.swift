//
//  ListArticlesView.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-20.
//

import SwiftUI
import NewsCore

struct ShowArticleView: View {
    @State var article: Article
    @State var isFavorite: Bool
    
    let action: ShowArticleActionCreator?
    
    var body: some View {
        Text(article.content ?? "")
            .navigationBarTitle(Text(article.title))
            .navigationBarItems(trailing:
                Button(
                    action: { self.action?.toggleFavorite(id: self.article.id) }
                ) {
                    Text(isFavorite ? "Unfavorite" : "Favorite").font(.body)
                }
            )
    }
}

#if DEBUG
struct ShowArticleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ShowArticleView(
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
                isFavorite: false,
                action: nil
            )
        }
    }
}
#endif
