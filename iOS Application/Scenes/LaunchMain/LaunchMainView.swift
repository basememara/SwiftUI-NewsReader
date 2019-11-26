//
//  LaunchMainView.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-13.
//

import SwiftUI
import NewsCore

struct LaunchMainView: View {
    @State private var selectedTab: Tab = .latest

    let render: LaunchMainRender
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                render.listArticles()
            }
            .tabItem {
                Image(systemName: "doc.text")
                Text("Latest")
            }
            .tag(Tab.latest)
            NavigationView {
                render.listFavorites()
            }
            .tabItem {
                Image(systemName: "star.fill")
                Text("Favorites")
            }
            .tag(Tab.favorites)
            NavigationView {
                render.showProfile()
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
            .tag(Tab.profile)
            NavigationView {
                render.showSettings()
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
            .tag(Tab.settings)
        }
    }
}

// MARK: - Subtypes

private extension LaunchMainView {
    
    enum Tab: Int {
        case latest
        case favorites
        case profile
        case settings
    }
}

#if DEBUG
struct LaunchMainView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchMainView(
            render: LaunchMainRender(
                from: SceneRender(
                    core: AppCore(),
                    store: AppStore()
                )
            )
        )
    }
}
#endif
