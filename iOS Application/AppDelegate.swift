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
        LoggerPlugin(log: UIApplication.shared.config.dependency()),
        CachePlugin(
            dataWorker: UIApplication.shared.config.dependency(),
            log: UIApplication.shared.config.dependency()
        )
    ]}
}

// MARK: - Dependency Injection

private extension UIApplication {
    private static let config = AppConfig()
    private static let state = AppState()
    private static let composer = SceneComposer(
        config: config,
        state: state
    )
    
    var config: NewsCoreConfig { Self.config }
    var state: AppState { Self.state }
    var composer: SceneComposer { Self.composer }
}

extension UISceneDelegate {
    var config: NewsCoreConfig { UIApplication.shared.config }
    var state: AppState { UIApplication.shared.state }
    var composer: SceneComposer { UIApplication.shared.composer }
}
