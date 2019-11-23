//
//  LaunchMainView.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-13.
//

import SwiftUI
import NewsCore

struct LaunchMainView: View {
    @State private var selectionTab = Tab.latest

    let composer: LaunchMainComposer
    
    var body: some View {
        TabView(selection: $selectionTab) {
            composer.listArticles()
                .font(.title)
                .tabItem({
                    Image(systemName: "doc.text")
                    Text("Latest")
                })
                .tag(Tab.latest)
            composer.listFavorites()
                .font(.title)
                .tabItem({
                    Image(systemName: "star.fill")
                    Text("Favorites")
                })
                .tag(Tab.favorites)
            composer.showProfile()
                .font(.title)
                .tabItem({
                    Image(systemName: "person.fill")
                    Text("Profile")
                })
                .tag(Tab.profile)
            composer.showSettings()
                .font(.title)
                .tabItem({
                    Image(systemName: "gear")
                    Text("Settings")
                })
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
        composer.launchMain()
    }
}
#endif
