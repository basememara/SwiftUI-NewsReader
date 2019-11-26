//
//  AppCore.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-20.
//

import Foundation
import NewsCore

struct AppCore: NewsCore {
    private let environment: Environment
    
    init() {
        #if DEBUG
        environment = .development
        #else
        environment = .production
        #endif
    }
    
    func dependencyStore() -> ConstantsStore {
        ConstantsMemoryStore(
            environment: environment,
            baseURL: URL(string: "https://newsapi.org")!,
            baseREST: "v2",
            newsAPIKey: "c74cc627b59441ca81985ed28e097db9",
            defaultFetchSources: [
                "al-jazeera-english",
                "associated-press",
                "axios",
                "bloomberg",
                "business-insider",
                "buzzfeed",
                "cnn",
                "engadget",
                "fortune",
                "google-news",
                "hacker-news",
                "mashable",
                "msnbc",
                "national-geographic",
                "newsweek",
                "reuters",
                "techcrunch",
                "the-huffington-post",
                "the-verge",
                "wired"
            ],
            defaultFetchModifiedLimit: 25,
            minLogLevel: environment == .production ? .warning : .debug
        )
    }
    
    func dependencyStore() -> PreferencesStore {
        PreferencesDefaultsStore(
            defaults: {
                UserDefaults(
                    suiteName: {
                        switch environment {
                        case .development:
                            return "group.io.zamzam.NewsReader-dev"
                        case .production:
                            return "group.io.zamzam.NewsReader"
                        }
                    }()
                ) ?? .standard
            }()
        )
    }
    
    func dependency() -> SeedStore {
        SeedFileStore(
            forResource: "seed.json",
            inBundle: .main,
            jsonDecoder: dependency()
        )
    }
    
    func dependency() -> [LogStore] {
        let constants: ConstantsType = dependency()
        
        return [
            LogConsoleStore(
                minLevel: constants.environment == .production ? .none
                    : constants.minLogLevel
            ),
            LogOSStore(
                minLevel: constants.minLogLevel,
                subsystem: Bundle.main.bundleIdentifier ?? "NewsReader",
                category: "Application"
            )
        ]
    }
    
    func dependency() -> Theme {
        DefaultTheme()
    }
}
