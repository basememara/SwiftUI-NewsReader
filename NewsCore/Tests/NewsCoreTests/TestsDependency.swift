//
//  TestsDependency.swift
//  NewsCoreTests
//
//  Created by Basem Emara on 2019-11-18.
//

import Foundation
@testable import NewsCore

struct TestsDependency: NewsCoreDependency {
    
    func resolveStore() -> ConstantsStore {
        ConstantsMemoryStore(
            environment: .development,
            baseURL: URL(string: "https://newsapi.org")!,
            baseREST: "v2",
            newsAPIKey: "c74cc627b59441ca81985ed28e097db9",
            defaultFetchSources: [
                "hacker-news",
                "techcrunch",
                "wired"
            ],
            defaultFetchModifiedLimit: 25,
            minLogLevel: .verbose
        )
    }
    
    func resolveStore() -> PreferencesStore {
        PreferencesDefaultsStore(defaults: .test)
    }
    
    func resolve() -> SeedStore {
        SeedJSONStore(
            jsonString: jsonString,
            jsonDecoder: resolve()
        )
    }
    
    func resolve() -> [LogStore] {
        [LogConsoleStore(minLevel: .verbose)]
    }
    
    func resolve() -> Theme {
        fatalError("Not implemented")
    }
}

private extension TestsDependency {
    
    struct SeedJSONStore: SeedStore {
        private static var data: CorePayload?
        
        private let jsonString: String
        private let jsonDecoder: JSONDecoder
        
        init(jsonString: String, jsonDecoder: JSONDecoder) {
            self.jsonString = jsonString
            self.jsonDecoder = jsonDecoder
        }
        
        func configure() {
            guard Self.data == nil else { return }
            
            Self.data = try? jsonDecoder.decode(
                CorePayload.self,
                from: jsonString
            )
        }
        
        func fetch(completion: @escaping (Result<CorePayload, DataError>) -> Void) {
            completion(.success(Self.data ?? CorePayload()))
        }
    }
}
