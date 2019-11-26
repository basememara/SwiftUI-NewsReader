//
//  LaunchMainRender.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-22.
//

import NewsCore
import SwiftUI

/// Sub-render instead of exposing entire root scene render to view.
struct LaunchMainRender: RenderType {
    private let parent: SceneRender
    
    init(parent: SceneRender) {
        self.parent = parent
    }
}

extension LaunchMainRender {
    
    func listArticles() -> some View {
        parent.listArticles()
    }
    
    func listFavorites() -> some View {
        parent.listFavorites()
    }
    
    func showProfile() -> some View {
        parent.showProfile()
    }
    
    func showSettings() -> some View {
        parent.showSettings()
    }
}
