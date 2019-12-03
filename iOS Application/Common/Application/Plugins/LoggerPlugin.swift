//
//  LoggerPlugin.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-21.
//

import UIKit
import NewsCore

struct LoggerPlugin {
    private let log: LogProviderType
    
    init(log: LogProviderType) {
        self.log = log
    }
}

extension LoggerPlugin: ApplicationPlugin {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        log.info("App did finish launching.")
        return true
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        log.warning("App did receive memory warning.")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        log.warning("App will terminate.")
    }
}

extension LoggerPlugin: ScenePlugin {
    
    func sceneWillEnterForeground() {
        log.debug("App will enter foreground.")
    }
    
    func sceneDidEnterBackground() {
        log.debug("App did enter background.")
    }
    
    func sceneDidBecomeActive() {
        log.debug("App did become active.")
    }
    
    func sceneWillResignActive() {
        log.debug("App did will resign active.")
    }
}
