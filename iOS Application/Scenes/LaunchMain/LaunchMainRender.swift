//
//  LaunchMainRender.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-22.
//

import NewsCore
import SwiftUI

struct LaunchMainRender: RenderType {
    private let render: SceneRender
    
    init(from render: SceneRender) {
        self.render = render
    }
}

extension LaunchMainRender {
    
    func listArticles() -> some View {
        render.listArticles()
    }
    
    func listFavorites() -> some View {
        render.listFavorites()
    }
    
    func showProfile() -> some View {
        render.showProfile()
    }
    
    func showSettings() -> some View {
        render.showSettings()
    }
}
