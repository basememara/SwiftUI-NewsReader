//
//  AppDelegate.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-20.
//

import UIKit
import NewsCore

@UIApplicationMain
class AppDelegate: ApplicationPluggableDelegate {
    
    override func plugins() -> [ApplicationPlugin] {[
        LoggerPlugin(log: core.dependency()),
        CachePlugin(dataProvider: core.dependency(), log: core.dependency())
    ]}
}

// MARK: - Environment Components

private enum Root {
    
    /// Root dependency injection container
    static let core = AppCore()
    
    /// Root application storage
    static let state = AppState()
    
    /// Root builder for all scenes.
    ///
    ///     NavigationView(
    ///         render.listArticles()
    ///     )
    ///
    /// Create views only through scene renders.
    static let render = SceneRender(
        core: core,
        state: state,
        middleware: [ // All actions pass through
            AnalyticsMiddleware()
        ]
    )
}

private extension UIApplicationDelegate {
    var core: NewsCore { Root.core }
}

extension UISceneDelegate {
    var core: NewsCore { Root.core }
    var render: SceneRender { Root.render }
}
