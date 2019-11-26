//
//  TestsCore.swift
//  NewsCoreTests
//
//  Created by Basem Emara on 2019-11-18.
//

import Foundation
@testable import NewsCore

struct TestsCore: NewsCore {
    
    func dependencyStore() -> ConstantsStore {
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
    
    func dependencyStore() -> PreferencesStore {
        PreferencesDefaultsStore(defaults: .test)
    }
    
    func dependency() -> SeedStore {
        SeedJSONStore(
            jsonString: jsonString,
            jsonDecoder: dependency()
        )
    }
    
    func dependency() -> [LogStore] {
        [LogConsoleStore(minLevel: .verbose)]
    }
    
    func dependency() -> Theme {
        fatalError("Not implemented")
    }
}

private extension TestsCore {
    
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
