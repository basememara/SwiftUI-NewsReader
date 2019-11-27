//
//  ReducerType.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-22.
//

/// The reducer to dispatch an action to state for the scene.
protocol ReducerType {
    associatedtype Action = ActionType
    
    /// Performs the logic and mutates the store.
    /// - Parameters:
    ///   - store: The global store for the application
    ///   - action: The action to perform on the store.
    func apply(_ store: AppStore, _ action: Action)
}
