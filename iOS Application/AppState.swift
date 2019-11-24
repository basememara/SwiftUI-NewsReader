//
//  AppState.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-20.
//

import Foundation
import Combine
import NewsCore

class AppState: ObservableObject {
    @Published var articles: [Article] = []
    @Published var favorites: [String] = []
}
