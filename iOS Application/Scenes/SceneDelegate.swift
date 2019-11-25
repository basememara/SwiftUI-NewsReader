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
        LoggerPlugin(log: config.dependency()),
        WindowPlugin(for: self, log: config.dependency())
    ]}
}
