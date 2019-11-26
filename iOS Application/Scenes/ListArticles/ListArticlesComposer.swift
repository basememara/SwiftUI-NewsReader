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
    
    init(from composer: SceneComposer) {
        self.composer = composer
    }
}

extension ListArticlesComposer {
    
    func showArticle(_ model: Article) -> some View {
        composer.showArticle(model)
    }
}
