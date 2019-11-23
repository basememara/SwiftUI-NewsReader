//
//  ListArticlesComposer.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-22.
//

import NewsCore
import SwiftUI

struct ListArticlesComposer: ComposerType {
    private let composer: SceneComposer
    
    func showArticle(for article: Article) -> some View {
        composer.showArticle(for: article)
    }
    
    init(from composer: SceneComposer) {
        self.composer = composer
    }
}
