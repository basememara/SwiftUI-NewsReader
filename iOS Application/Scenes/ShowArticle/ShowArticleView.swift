//
//  ListArticlesView.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-20.
//

import SwiftUI
import NewsCore

struct ShowArticleView: View {
    let article: Article
    
    var body: some View {
        Text(article.title)
    }
}
