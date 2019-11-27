//
//  NewsCore.swift
//  NewsCore
//
//  Created by Basem Emara on 2019-11-18.
//

import Foundation

/// Dependency container used to resolve instances.
///
/// Implement and use as root instance factory.
public protocol NewsCore {
    func dependency() -> ConstantsType
    func dependencyStore() -> ConstantsStore
    
    func dependency() -> PreferencesType
    func dependencyStore() -> PreferencesStore
    
    func dependency() -> DataProviderType
    func dependency() -> SeedStore
    func dependency() -> RemoteStore
    func dependency() -> CacheStore
    
    func dependency() -> ArticleProviderType
    func dependency() -> ArticleCache
    func dependency() -> ArticleRemote
    
    func dependency() -> FavoriteProviderType
    func dependency() -> FavoriteStore
    
    func dependency() -> NetworkServiceType
    func dependency() -> NetworkStore
    
    func dependency() -> LogProviderType
    func dependency() -> [LogStore]
    
    func dependency() -> NotificationCenter
    func dependency() -> FileManager
    func dependency() -> JSONDecoder
    func dependency() -> JSONEncoder

    func dependency() -> Theme
}

// MARK: - Preferences

public extension NewsCore {
    
    func dependency() -> ConstantsType {
        Constants(store: dependencyStore())
    }
}

public extension NewsCore {
    
    func dependency() -> PreferencesType {
        Preferences(store: dependencyStore())
    }
}

// MARK: - Providers

public extension NewsCore {
    
    func dependency() -> DataProviderType {
        DataProvider(
            constants: dependency(),
            cacheStore: dependency(),
            seedStore: dependency(),
            remoteStore: dependency(),
            log: dependency()
        )
    }
    
    func dependency() -> RemoteStore {
        RemoteNetworkStore(
            articleRemote: dependency(),
            log: dependency()
        )
    }
    
    func dependency() -> CacheStore {
        CacheDiskStore(
            fileManager: dependency(),
            jsonDecoder: dependency(),
            jsonEncoder: dependency(),
            constants: dependency(),
            log: dependency()
        )
    }
}

public extension NewsCore {
    
    func dependency() -> ArticleProviderType {
        ArticleProvider(
            store: dependency(),
            dataProvider: dependency()
        )
    }
    
    func dependency() -> ArticleCache {
        ArticleDiskStore(
            store: dependency(),
            fileManager: dependency(),
            jsonDecoder: dependency(),
            jsonEncoder: dependency(),
            constants: dependency(),
            log: dependency()
        )
    }
    
    func dependency() -> ArticleRemote {
        ArticleNetworkStore(
            networkService: dependency(),
            jsonDecoder: dependency(),
            constants: dependency(),
            log: dependency()
        )
    }
}

public extension NewsCore {
    
    func dependency() -> FavoriteProviderType {
        FavoriteProvider(store: dependency())
    }
    
    func dependency() -> FavoriteStore {
        FavoritePreferencesStore(preferences: dependency())
    }
}

public extension NewsCore {
    
    func dependency() -> NetworkServiceType {
        NetworkService(store: dependency())
    }
    
    func dependency() -> NetworkStore {
        NetworkFoundationStore()
    }
}

public extension NewsCore {
    
    func dependency() -> LogProviderType {
        LogProvider(stores: dependency())
    }
    
    func dependency() -> [LogStore] {
        let constants: ConstantsType = dependency()
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

public extension NewsCore {
    
    func dependency() -> NotificationCenter {
        .default
    }
    
    func dependency() -> FileManager {
        .default
    }
    
    func dependency() -> JSONDecoder {
        .default
    }
    
    func dependency() -> JSONEncoder {
        .default
    }
}
