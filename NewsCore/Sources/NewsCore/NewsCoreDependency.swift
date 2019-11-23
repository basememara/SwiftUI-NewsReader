//
//  NewsCoreDependency.swift
//  NewsCore
//
//  Created by Basem Emara on 2019-11-18.
//

import Foundation

/// Dependency container used to resolve instances.
///
/// Implement and use as root instance factory.
public protocol NewsCoreDependency {
    func resolve() -> ConstantsType
    func resolveStore() -> ConstantsStore
    
    func resolve() -> PreferencesType
    func resolveStore() -> PreferencesStore
    
    func resolve() -> DataWorkerType
    func resolve() -> SeedStore
    func resolve() -> RemoteStore
    func resolve() -> CacheStore
    
    func resolve() -> ArticleWorkerType
    func resolve() -> ArticleCache
    func resolve() -> ArticleRemote
    
    func resolve() -> NetworkServiceType
    func resolve() -> NetworkStore
    
    func resolve() -> LogWorkerType
    func resolve() -> [LogStore]
    
    func resolve() -> NotificationCenter
    func resolve() -> FileManager
    func resolve() -> JSONDecoder
    func resolve() -> JSONEncoder

    func resolve() -> Theme
}

// MARK: - Preferences

public extension NewsCoreDependency {
    
    func resolve() -> ConstantsType {
        Constants(store: resolveStore())
    }
}

public extension NewsCoreDependency {
    
    func resolve() -> PreferencesType {
        Preferences(store: resolveStore())
    }
}

// MARK: - Workers

public extension NewsCoreDependency {
    
    func resolve() -> DataWorkerType {
        DataWorker(
            constants: resolve(),
            cacheStore: resolve(),
            seedStore: resolve(),
            remoteStore: resolve(),
            log: resolve()
        )
    }
    
    func resolve() -> RemoteStore {
        RemoteNetworkStore(
            articleRemote: resolve(),
            log: resolve()
        )
    }
    
    func resolve() -> CacheStore {
        CacheDiskStore(
            fileManager: resolve(),
            jsonDecoder: resolve(),
            jsonEncoder: resolve(),
            constants: resolve(),
            log: resolve()
        )
    }
}

public extension NewsCoreDependency {
    
    func resolve() -> ArticleWorkerType {
        ArticleWorker(
            store: resolve(),
            dataWorker: resolve()
        )
    }
    
    func resolve() -> ArticleCache {
        ArticleDiskStore(
            store: resolve(),
            fileManager: resolve(),
            jsonDecoder: resolve(),
            jsonEncoder: resolve(),
            constants: resolve(),
            log: resolve()
        )
    }
    
    func resolve() -> ArticleRemote {
        ArticleNetworkStore(
            networkService: resolve(),
            jsonDecoder: resolve(),
            constants: resolve(),
            log: resolve()
        )
    }
}

public extension NewsCoreDependency {
    
    func resolve() -> NetworkServiceType {
        NetworkService(store: resolve())
    }
    
    func resolve() -> NetworkStore {
        NetworkFoundationStore()
    }
}

public extension NewsCoreDependency {
    
    func resolve() -> LogWorkerType {
        LogWorker(stores: resolve())
    }
    
    func resolve() -> [LogStore] {
        let constants: ConstantsType = resolve()
        let minLogLevel: LogAPI.Level = constants.environment == .production ? .info : .debug
        
        return [
            LogConsoleStore(
                minLevel: constants.environment == .production ? .none : minLogLevel
            ),
            LogOSStore(
                minLevel: minLogLevel,
                subsystem: Bundle.main.bundleIdentifier ?? "NewsCore",
                category: "Application"
            )
        ]
    }
}

// MARK: - Infrastructure

public extension NewsCoreDependency {
    
    func resolve() -> NotificationCenter {
        .default
    }
    
    func resolve() -> FileManager {
        .default
    }
    
    func resolve() -> JSONDecoder {
        .default
    }
    
    func resolve() -> JSONEncoder {
        .default
    }
}
