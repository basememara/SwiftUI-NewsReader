//
//  StoreType.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-25.
//

/// The global storage.
protocol StoreType {}

/// Closure for mutating application store in reducers
typealias MutateStoreFunction = ((AppStore) -> Void) -> Void
