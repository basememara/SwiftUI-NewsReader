//
//  Constants.swift
//
//  Created by Basem Emara on 2019-11-18.
//

import Foundation

public struct Constants: ConstantsType {
    private let store: ConstantsStore
    
    public init(store: ConstantsStore) {
        self.store = store
    }
}

public extension Constants {
    var environment: Environment { store.environment}
}

public extension Constants {
    var baseURL: URL { store.baseURL }
    var baseREST: String { store.baseREST }
}

public extension Constants {
    var newsAPIKey: String { store.newsAPIKey }
    var defaultFetchSources: [String] { store.defaultFetchSources }
    var defaultFetchModifiedLimit: Int { store.defaultFetchModifiedLimit }
    var minLogLevel: LogAPI.Level { store.minLogLevel }
}
