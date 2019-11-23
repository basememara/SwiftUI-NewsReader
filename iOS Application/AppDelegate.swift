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
    let dependency = AppDependency()
    let state = AppState()
    
    override func plugins() -> [ApplicationPlugin] {[
        LoggerPlugin(log: dependency.resolve()),
        DataPlugin(dataWorker: dependency.resolve()),
        SchedulerPlugin(log: dependency.resolve()),
        NotificationPlugin(log: dependency.resolve())
    ]}
}
