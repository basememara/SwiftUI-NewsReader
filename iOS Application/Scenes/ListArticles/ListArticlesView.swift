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
                Button(action: { self.state.dispatch(.loadArticles) }) {
                    Text(self.state.articles.isEmpty ? "Load" : "Clear")
                }
            )
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
