//
//  DataPlugin.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-21.
//

import UIKit
import NewsCore

final class DataPlugin {
    private let dataWorker: DataWorkerType
    
    init(dataWorker: DataWorkerType) {
        self.dataWorker = dataWorker
    }
}

extension DataPlugin: ApplicationPlugin {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        dataWorker.configure()
        dataWorker.pull() // Prefetch
        return true
    }
}
