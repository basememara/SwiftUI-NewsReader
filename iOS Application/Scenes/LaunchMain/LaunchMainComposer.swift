//
//  LaunchMainComposer.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-22.
//

import SwiftUI
import NewsCore

struct LaunchMainComposer {
    private let composer: SceneComposer
    
    init(from composer: SceneComposer) {
        self.composer = composer
    }
}

extension LaunchMainComposer {
    
    func listArticles() -> some View {
        composer.listArticles()
    }
    
    func listFavorites() -> some View {
        composer.listFavorites()
    }
    
    func showProfile() -> some View {
        composer.showProfile()
    }
    
    func showSettings() -> some View {
        composer.showSettings()
    }
}
