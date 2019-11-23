//
//  SchedulerPlugin.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-21.
//

import NewsCore

final class SchedulerPlugin {
    private let log: LogWorkerType

    init(log: LogWorkerType) {
        self.log = log
    }
}

extension SchedulerPlugin: ApplicationPlugin {
    
}

extension SchedulerPlugin: ScenePlugin {
    
}
