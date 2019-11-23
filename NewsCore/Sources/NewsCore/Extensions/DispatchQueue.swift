//
//  DispatchQueue.swift
//  NewsCore
//
//  Created by Basem Emara on 2019-11-18.
//

import Foundation

extension DispatchQueue {
    static let labelPrefix = "NewsCore.DispatchQueue"
}

public extension DispatchQueue {
    
    /// A configured queue for executing database related work items.
    static let database = DispatchQueue(label: "\(DispatchQueue.labelPrefix).database", qos: .utility)
    
    /// A configured queue for executing parsing or decoding related work items.
    static let transform = DispatchQueue(label: "\(DispatchQueue.labelPrefix).transform", qos: .userInitiated)
    
    /// A configured queue for executing logger related work items.
    static let logger = DispatchQueue(label: "\(DispatchQueue.labelPrefix).logger", qos: .background)
}
