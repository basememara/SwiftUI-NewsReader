//
//  ListArticlesRender.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-22.
//

import NewsCore
import SwiftUI

struct ListArticlesRender: RenderType {
    private let parent: SceneRender
    
    init(parent: SceneRender) {
        self.parent = parent
    }
}

extension ListArticlesRender {
    
    func showArticle(_ model: Article) -> some View {
        parent.showArticle(model)
    }
}
