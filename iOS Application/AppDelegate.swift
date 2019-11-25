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
        LoggerPlugin(log: config.dependency()),
        CachePlugin(dataWorker: config.dependency(), log: config.dependency())
    ]}
}

// MARK: - Environment Components

private extension UIApplication {
    static let config = AppConfig()
    static let state = AppState()
    static let composer = SceneComposer(
        config: config,
        state: state
    )
}

extension UIApplicationDelegate {
    var config: NewsCoreConfig { UIApplication.config }
}

extension UISceneDelegate {
    var config: NewsCoreConfig { UIApplication.config }
    var composer: SceneComposer { UIApplication.composer }
}
