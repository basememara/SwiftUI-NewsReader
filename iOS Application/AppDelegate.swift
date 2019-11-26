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
        CachePlugin(dataWorker: core.dependency(), log: core.dependency())
    ]}
}

// MARK: - Environment Components

private extension UIApplication {
    static let core = AppCore()
    static let store = AppStore()
    static let composer = SceneComposer(
        core: core,
        store: store
    )
}

extension UIApplicationDelegate {
    var core: NewsCore { UIApplication.core }
}

extension UISceneDelegate {
    var core: NewsCore { UIApplication.core }
    var composer: SceneComposer { UIApplication.composer }
}
