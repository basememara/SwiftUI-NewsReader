//
//  ListArticlesView.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-20.
//

import SwiftUI
import NewsCore

struct ListArticlesView: View {
    @EnvironmentObject var dependency: AppDependency
    @EnvironmentObject var composer: SceneComposer
    
    let articles: [Article] // Immutable, only updates from the top
    
    var body: some View {
        NavigationView {
            List(articles) { article in
                NavigationLink(destination: self.composer.showArticle(for: article)) {
                    Text(article.title)
                }
            }
            .navigationBarTitle(Text("News"))
            .navigationBarItems(trailing:
                Button(
                    action: {
                        // TODO: Temporary until scene flow architecture put in place
                        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                        
                        guard self.articles.isEmpty else {
                            appDelegate.state.articles = []
                            return
                        }
                        
                        let articleWorker: ArticleWorkerType = self.dependency.resolve()
                        articleWorker.fetch(with: .init()) {
                            guard case .success(let value) = $0 else { return }
                            appDelegate.state.articles = value
                        }
                    },
                    label: {
                        Text(articles.isEmpty ? "Load" : "Clear")
                    }
                )
            )
        }
    }
}
