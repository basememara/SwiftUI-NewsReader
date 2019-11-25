//
//  AppState.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-20.
//

import Foundation
import Combine
import NewsCore

class AppState: StateType, ObservableObject {
    @Published var articles: [Article] = []
    @Published var favorites: [String] = []
}

// Closure for mutating application state in reducers
typealias MutateStateFunction = ((AppState) -> Void) -> Void
