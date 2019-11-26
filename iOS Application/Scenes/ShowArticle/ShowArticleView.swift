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
    
    @State var text: String
    @State var date: Date
    @State var quantity: Int
    @State var selection: String
    
    let dispatch: Dispatcher<ShowArticleAction>
    
    var body: some View {
        Form {
            Section {
                Text(state.article.title)
                TextField("Text", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Stepper(value: $quantity, in: 0...10) {
                    Text("Quantity")
                }
            }
            Section {
                DatePicker(selection: $date) {
                    Text("Published Date")
                }
                Picker(
                    selection: $selection,
                    label: Text("Picker Name"),
                    content: {
                        Text("Value 1").tag(0)
                        Text("Value 2").tag(1)
                        Text("Value 3").tag(2)
                        Text("Value 4").tag(3)
                    }
                )
            }
            Section {
                Text(text)
                Text("\(quantity)")
                Text("\(date)")
                Text(selection)
            }
        }
        .navigationBarTitle(Text("Article"))
        .navigationBarItems(trailing:
            Button(action: {
                self.dispatch(.toggleFavorite(id: self.state.article.id)) }
            ) {
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
                    model: Article(
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
                text: "Test string",
                date: Date(),
                quantity: 99,
                selection: "Value 1",
                dispatch: { _ in }
            )
        }
    }
}
#endif
