//
//  NotificationPlugin.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-21.
//

import NewsCore

final class NotificationPlugin: ApplicationPlugin {
    private let log: LogWorkerType
    
    init(log: LogWorkerType) {
        self.log = log
    }
}
