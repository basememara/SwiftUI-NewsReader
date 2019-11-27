//
//  ListArticlesRender.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-22.
//

import NewsCore
import SwiftUI

/// Constructs a scene without exposing the entire `SceneRender` to the view.
struct ListArticlesRender: RenderType {
    private let parent: SceneRender
    
    init(parent: SceneRender) {
        self.parent = parent
    }
}

extension ListArticlesRender {
    
    func showArticle(id: String) -> some View {
        parent.showArticle(id: id)
    }
}
