//
//  CacheDiskStore.swift
//  NewsCore
//
//  Created by Basem Emara on 2019-11-18.
//

import Foundation

public struct CacheDiskStore: CacheStore {
    private let fileManager: FileManager
    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder
    private let constants: ConstantsType
    private let log: LogWorkerType
    
    public init(
        fileManager: FileManager,
        jsonDecoder: JSONDecoder,
        jsonEncoder: JSONEncoder,
        constants: ConstantsType,
        log: LogWorkerType
    ) {
        self.fileManager = fileManager
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
        self.constants = constants
        self.log = log
    }
}

public extension CacheDiskStore {
    
    /// Create default location, set permissions, and seed if applicable
    func configure() -> URL? {
        // Validate before initializing storage
        guard let directoryURL = directoryURL else {
            log.error("Cache storage could not determine the application directory.")
            return nil
        }
        
        // Skip if already set up before
        guard !fileManager.fileExists(atPath: directoryURL.path) else {
            log.debug("Cache storage already initialized at: \(self.directoryURL?.path ?? "unknown")")
            return directoryURL
        }
        
        do {
            // Create directory if does not exist yet
            try fileManager.createDirectory(
                atPath: directoryURL.path,
                withIntermediateDirectories: true,
                attributes: {
                    #if !os(macOS)
                    // Set permissions for storage for background tasks
                    return [.protectionKey: FileProtectionType.completeUntilFirstUserAuthentication]
                    #else
                    return nil
                    #endif
                }()
            )
            
            log.debug("Cache storage initialized at: \(directoryURL)")
            log.info("Cache storage configured for \(name).")
        } catch {
            log.error("Could not set permissions to cache folder: \(error)")
        }
        
        return directoryURL
    }
}

public extension CacheDiskStore {
    
    var lastUpdatedAt: Date? { lastUpdatedAt(for: CorePayload.self) }
    
    func lastUpdatedAt<T>(for type: T.Type) -> Date? {
        guard let path = url(for: type)?.path else { return nil }
        return try? fileManager.attributesOfItem(atPath: path)[.modificationDate] as? Date
    }
    
    func url<T>(for type: T.Type) -> URL? {
        directoryURL?.appendingPathComponent(
            "\(name).\(String(describing: type)).\(constants.environment).json"
        )
    }
}

public extension CacheDiskStore {
    
    func createOrUpdate(with request: DataAPI.CacheRequest, completion: @escaping (Result<CorePayload, DataError>) -> Void) {
        // Ensure there is data before proceeding
        guard !request.payload.isEmpty else {
            log.debug("No modified data to cache.")
            DispatchQueue.main.async { completion(.success(request.payload)) }
            return
        }
        
        // Write source data to local storage
        DispatchQueue.database.async {
            do {
                if let articleURL = self.url(for: Article.self) {
                    let previousModels: [Article] = try {
                        guard let data = self.fileManager.contents(atPath: articleURL.path) else { return [] }
                        return try self.jsonDecoder.decode([Article].self, from: data)
                    }()
                    
                    let newIDs = request.payload.articles.map { $0.id }
                    
                    self.fileManager.createFile(
                        atPath: articleURL.path,
                        contents: try self.jsonEncoder.encode(
                            previousModels.filter { !newIDs.contains($0.id) } + request.payload.articles
                        )
                    )
                } else {
                    throw DataError.cacheFailure(nil)
                }
                
                self.set(lastUpdatedAt: request.lastUpdatedAt)
                self.log.debug("Cache modified data complete for \(request.payload.articles.count) articles.")
                
                DispatchQueue.main.async { completion(.success(request.payload)) }
                return
            } catch {
                self.log.error("Could not write modified data to cache from the source: \(error)")
                DispatchQueue.main.async { completion(.failure(.cacheFailure(error))) }
                return
            }
        }
    }
}

public extension CacheDiskStore {
    
    func delete() {
        guard let directoryURL = directoryURL else { return }
        
        do {
            let filenames = try fileManager.contentsOfDirectory(atPath: directoryURL.path)
            
            try filenames
                .filter { $0.hasPrefix("\(name).") && $0.hasSuffix(".\(constants.environment).json") }
                .forEach { try fileManager.removeItem(atPath: directoryURL.appendingPathComponent($0).path) }
            
            log.warning("Deleted cache storage for \(name) at: \(directoryURL)")
        } catch {
            log.error("Could not delete user's cache: \(error)")
        }
    }
}

// MARK: - Helpers

private extension CacheDiskStore {
    
    /// Name for isolated database per user or use anonymously
    var name: String {
        "user_0" // Anonymous until login/logout put in place
    }
    
    var directoryURL: URL? {
        fileManager
            .urls(for: .applicationSupportDirectory, in: .userDomainMask).first?
            .appendingPathComponent("NewsCore")
    }
    
    func set(lastUpdatedAt date: Date) {
        guard let url = url(for: CorePayload.self) else { return }
        
        if !fileManager.fileExists(atPath: url.path) {
            try? "".write(to: url, atomically: true, encoding: .utf8)
        }
        
        try? fileManager.setAttributes([.modificationDate: date], ofItemAtPath: url.path)
    }
}
