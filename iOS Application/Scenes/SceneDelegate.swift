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
        WindowPlugin(for: self, log: dependency.resolve())
    ]}
}
