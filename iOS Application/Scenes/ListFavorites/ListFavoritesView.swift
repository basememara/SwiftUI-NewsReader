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
    
    let dispatch: Dispatcher<ListFavoritesAction>
    
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
                
                self.dispatch(.toggleFavorite(id: article.id))
            }
        }
        .navigationBarTitle(Text("Favorites"))
        .onAppear {
            self.dispatch(.loadFavorites)
        }
    }
}

#if DEBUG
struct ListFavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListFavoritesView(
                state: ListFavoritesState(
                    model: [
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
                dispatch: {
                    print("Action: \($0)")
                }
            )
        }
    }
}
#endif

