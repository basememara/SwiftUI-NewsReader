//
//  ListArticlesView.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-20.
//

import SwiftUI
import NewsCore

struct ListArticlesView: View {
    @ObservedObject var state: ListArticlesState
    
    let action: ListArticlesAction
    let composer: ListArticlesComposer
    
    var body: some View {
        NavigationView {
            List(state.articles) { article in
                NavigationLink(destination: self.composer.showArticle(for: article)) {
                    Text(article.title)
                }
            }
            .navigationBarTitle(Text("News"))
            .navigationBarItems(trailing:
                Button(
                    action: {
                        self.state.articles.isEmpty
                            ? self.action.loadArticles()
                            : self.action.clearArticles()
                    },
                    label: {
                        Text(self.state.articles.isEmpty ? "Load" : "Clear")
                    }
                )
            )
        }.onAppear {
            self.action.loadArticles()
        }
    }
}

#if DEBUG
struct ListArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        composer.listArticles()
    }
}
#endif
