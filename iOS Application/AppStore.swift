//
//  AppStore.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-20.
//

import Foundation
import Combine
import NewsCore

class AppStore: StateType, ObservableObject {
    @Published var articles: [Article] = []
    @Published var favorites: [String] = []
}

// Closure for mutating application store in reducers
typealias MutateStoreFunction = ((AppStore) -> Void) -> Void
