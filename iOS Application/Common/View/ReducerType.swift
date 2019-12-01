//
//  ReducerType.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-22.
//

/// The reducer to dispatch an action to state for the scene.
protocol ReducerType {
    associatedtype Action: ActionType
    
    /// Performs the logic and mutates the state.
    /// - Parameters:
    ///   - state: The global state for the application
    ///   - action: The action to perform on the state.
    @discardableResult
    func apply(_ state: AppState, _ action: Action) -> AppState
}
