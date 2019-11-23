//
//  SceneDelegate.swift
//  GoogleNews iOS
//
//  Created by Basem Emara on 2019-11-13.
//

import UIKit
import SwiftUI
import NewsCore

class SceneDelegate: ScenePluggableDelegate {
        
    override func plugins() -> [ScenePlugin] {[
        LoggerPlugin(log: dependency.resolve()),
        SchedulerPlugin(log: dependency.resolve()),
        WindowPlugin(
            for: self,
            dependency: dependency,
            state: state,
            composer: SceneComposer()
        )
    ]}
}

// MARK: - Injection

private extension SceneDelegate {
    var appDelegate: AppDelegate { UIApplication.shared.delegate as! AppDelegate }
    var dependency: AppDependency { appDelegate.dependency }
    var state: AppState { appDelegate.state }
}
