//
//  LogWorker.swift
//
//  Created by Basem Emara on 2019-11-18.
//

import Foundation

public struct LogWorker: LogWorkerType {
    private let stores: [LogStore]
    
    public init(stores: [LogStore]) {
        self.stores = stores
    }
}

public extension LogWorker {
    private static let queue = DispatchQueue(label: "NewsCore.LogWorker", qos: .utility)
    
    func write(_ level: LogAPI.Level, with message: String, path: String, function: String, line: Int, context: [String: Any]?, completion: (() -> Void)?) {
        let destinations = stores.filter { $0.canWrite(for: level) }
        
        // Skip if does not meet minimum log level
        guard !destinations.isEmpty else {
            completion?()
            return
        }
        
        Self.queue.async {
            destinations.forEach {
                $0.write(level, with: message, path: path, function: function, line: line, context: context)
            }
            
            completion?()
        }
    }
}
