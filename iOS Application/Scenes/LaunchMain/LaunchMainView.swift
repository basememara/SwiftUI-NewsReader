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

    let composer: LaunchMainComposer
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                composer.listArticles()
            }
            .tabItem {
                Image(systemName: "doc.text")
                Text("Latest")
            }
            .tag(Tab.latest)
            NavigationView {
                composer.listFavorites()
            }
            .tabItem {
                Image(systemName: "star.fill")
                Text("Favorites")
            }
            .tag(Tab.favorites)
            NavigationView {
                composer.showProfile()
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
            .tag(Tab.profile)
            NavigationView {
                composer.showSettings()
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
            composer: LaunchMainComposer(
                from: SceneComposer(
                    core: AppCore(),
                    store: AppStore()
                )
            )
        )
    }
}
#endif
