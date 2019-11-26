//
//  ListArticlesRender.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-22.
//

import NewsCore
import SwiftUI

struct ListArticlesRender: RenderType {
    private let render: SceneRender
    
    init(from render: SceneRender) {
        self.render = render
    }
}

extension ListArticlesRender {
    
    func showArticle(_ model: Article) -> some View {
        render.showArticle(model)
    }
}
