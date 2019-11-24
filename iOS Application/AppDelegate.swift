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
        LoggerPlugin(log: UIApplication.shared.dependency.resolve()),
        DataPlugin(dataWorker: UIApplication.shared.dependency.resolve()),
        SchedulerPlugin(log: UIApplication.shared.dependency.resolve()),
        NotificationPlugin(log: UIApplication.shared.dependency.resolve())
    ]}
}

// MARK: - Components / Injection

private extension UIApplication {
    private static let dependency = AppDependency()
    private static let state = AppState()
    private static let composer = SceneComposer(
        dependency: dependency,
        state: state
    )
    
    var dependency: NewsCoreDependency { Self.dependency }
    var state: AppState { Self.state }
    var composer: SceneComposer { Self.composer }
}

extension UISceneDelegate {
    var dependency: NewsCoreDependency { UIApplication.shared.dependency }
    var state: AppState { UIApplication.shared.state }
    var composer: SceneComposer { UIApplication.shared.composer }
}
