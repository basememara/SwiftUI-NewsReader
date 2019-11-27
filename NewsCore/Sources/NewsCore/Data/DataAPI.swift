//
//  DataAPI.swift
//  NewsCore
//  
//  Created by Basem Emara on 2019-11-18.
//

import Foundation

/// Data request namespace
public enum DataAPI {}

public protocol CacheStore {
    
    /// The date when the core payload was last updated.
    var lastUpdatedAt: Date? { get }
    
    /// The date when the type was last updated.
    /// - Parameter type: The type used to find the last modified date.
    func lastUpdatedAt<T>(for type: T.Type) -> Date?
    
    /// The location of a specified type.
    /// - Parameter type: The type used derive the location.
    func url<T>(for type: T.Type) -> URL?
    
    @discardableResult
    func configure() -> URL?
    
    func createOrUpdate(with request: DataAPI.CacheRequest, completion: @escaping (Result<CorePayload, DataError>) -> Void)
    func delete()
}

public protocol SeedStore {
    func configure()
    func fetch(completion: @escaping (Result<CorePayload, DataError>) -> Void)
}

public protocol RemoteStore {
    func configure()
    func fetchLatest(after date: Date?, with request: DataAPI.RemoteRequest, completion: @escaping (Result<CorePayload, DataError>) -> Void)
}

public protocol DataProviderType {
    
    /// Setup the underlying storage for use.
    func configure()
    
    /// Destroys the cache storage to start fresh.
    func reset()
    
    /// Retrieves the latest changes from the remote source.
    ///
    /// - Parameter completion: The completion block that returns the latest changes.
    func pull(completion: ((Result<CorePayload, DataError>) -> Void)?)
}

public extension DataProviderType {
    
    /// Retrieves the latest changes from the remote source.
    func pull() {
        pull(completion: nil)
    }
}

// MARK: - Requests/Responses

public extension DataAPI {
    
    struct RemoteRequest {}
    
    struct CacheRequest {
        let payload: CorePayload
        let lastUpdatedAt: Date
    }
}
