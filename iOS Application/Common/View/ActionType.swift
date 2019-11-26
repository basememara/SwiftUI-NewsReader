//
//  ActionType.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-22.
//

/// The action component of the scene.
protocol ActionType {}

/// Closure for wrapping an action to send to a reducer and store
typealias Dispatcher<T: ActionType> = (T) -> Void
