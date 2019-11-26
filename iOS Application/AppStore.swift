//
//  AppStore.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-20.
//

import Combine
import NewsCore

/// Global store for the application.
///
/// Only update on main thread since views are observing changes.
class AppStore: StoreType, ObservableObject {
    @Published var articles: [Article] = []
    @Published var favorites: [String] = []
}
