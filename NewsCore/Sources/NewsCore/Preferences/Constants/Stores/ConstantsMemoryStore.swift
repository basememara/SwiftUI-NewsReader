//
//  ConstantsStore.swift
//
//  Created by Basem Emara on 2019-11-18.
//

import Foundation

public struct ConstantsMemoryStore: ConstantsStore {
    public let environment: Environment
    public let baseURL: URL
    public let baseREST: String
    public let newsAPIKey: String
    public let defaultFetchSources: [String]
    public let defaultFetchModifiedLimit: Int
    public let minLogLevel: LogAPI.Level
    
    public init(
        environment: Environment,
        baseURL: URL,
        baseREST: String,
        newsAPIKey: String,
        defaultFetchSources: [String],
        defaultFetchModifiedLimit: Int,
        minLogLevel: LogAPI.Level
    ) {
        self.environment = environment
        self.baseURL = baseURL
        self.baseREST = baseREST
        self.newsAPIKey = newsAPIKey
        self.defaultFetchSources = defaultFetchSources
        self.defaultFetchModifiedLimit = defaultFetchModifiedLimit
        self.minLogLevel = minLogLevel
    }
}
