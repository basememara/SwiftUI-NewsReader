//
//  ConstantsStoreInterfaces.swift
//
//  Created by Basem Emara on 2019-11-18.
//

import Foundation

public protocol ConstantsStore {
    var environment: Environment { get }
    var baseURL: URL { get }
    var baseREST: String { get }
    var newsAPIKey: String { get }
    var defaultFetchSources: [String] { get }
    var defaultFetchModifiedLimit: Int { get }
    var minLogLevel: LogAPI.Level { get }
}

public protocol ConstantsType: ConstantsStore {}
