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
        LoggerPlugin(log: core.dependency()),
        WindowPlugin(for: self, log: core.dependency())
    ]}
}
