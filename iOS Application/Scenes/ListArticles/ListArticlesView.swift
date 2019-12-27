//
//  ListArticlesView.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-20.
//

import SwiftUI
import NewsCore

struct ListArticlesView: View {
    @ObservedObject private(set) var model: ListArticlesModel
    
    let action: ListArticlesActionCreator?
    let render: ListArticlesRender?
    
    var body: some View {
        List(model.articles) { article in
            NavigationLink(
                destination: self.render?
                    .showArticle(id: article.id)
            ) {
                Text(article.title)
                    .font(.body)
            }
        }
        .navigationBarTitle(Text("News"))
        .navigationBarItems(trailing:
            Button(
                action: {
                    self.model.articles.isEmpty
                        ? self.action?.fetchArticles()
                        : self.action?.clearArticles()
                },
                label: {
                    Text(self.model.articles.isEmpty ? "Load" : "Clear")
                        .font(.body)
                }
            )
        ).onAppear {
            self.action?.fetchArticles()
        }
    }
}

#if DEBUG
struct ListArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListArticlesView(
                model: ListArticlesModel(
                    articles: [
                        Article(
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
                        Article(
                            url: "http://example.com/2",
                            title: "Example article 2",
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
                        Article(
                            url: "http://example.com/3",
                            title: "Example article 3",
                            content: "This is a test content for 1.",
                            excerpt: "This is a test excecrpt",
                            image: nil,
                            author: nil,
                            publishedAt: Date(),
                            source: ArticleSource(
                                id: "google-news",
                                name: "Google News"
                            )
                        )
                    ]
                ),
                action: nil,
                render: nil
            )
        }
    }
}
#endif
