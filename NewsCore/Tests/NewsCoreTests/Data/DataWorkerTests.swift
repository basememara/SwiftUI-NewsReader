//
//  File.swift
//  
//
//  Created by Basem Emara on 2019-11-18.
//

import XCTest
@testable import NewsCore

final class DataWorkerTests: BaseTestCase {
    private lazy var worker: DataWorkerType = dependency.resolve()
    
    override func setUp() {
        super.setUp()
        
        dependency = LocalDependency()
        worker.configure()
    }
}

extension DataWorkerTests {
    
    func testFlowOfStores() {
        // Given
        let promise = expectation(description: "testFlowOfStores")
        
        // When
        worker.pull {
            defer { promise.fulfill() }
            
            guard case .success = $0 else {
                XCTFail("No results found")
                return
            }
            
            // Then
            // TODO: Fix testing
            XCTAssert(true)
        }
        
        wait(for: [promise], timeout: 10)
    }
}

// MARK: - Subtypes

private extension DataWorkerTests {
    
    struct LocalDependency: NewsCoreDependency {
        
        func resolveStore() -> ConstantsStore {
            ConstantsMemoryStore(
                environment: .development,
                baseURL: URL(string: "https://example.com")!,
                baseREST: "",
                newsAPIKey: "",
                defaultFetchSources: [],
                defaultFetchModifiedLimit: 0,
                minLogLevel: .verbose
            )
        }
        
        func resolveStore() -> PreferencesStore {
            PreferencesDefaultsStore(defaults: .test)
        }
        
        func resolve() -> CacheStore {
            CacheStoreSpy()
        }
        
        func resolve() -> SeedStore {
            SeedStoreSpy()
        }
        
        func resolve() -> RemoteStore {
            RemoteStoreSpy()
        }
        
        func resolve() -> [LogStore] {
            [LogConsoleStore(minLevel: .verbose)]
        }
        
        func resolve() -> Theme {
            fatalError("Not implemented")
        }
    }
}

private extension DataWorkerTests {
    
    class CacheStoreSpy: CacheStore {
        var lastUpdatedAt: Date?
        var wasCreateOrUpdateCalled = false
        
        func createOrUpdate(with request: DataAPI.CacheRequest, completion: @escaping (Result<CorePayload, DataError>) -> Void) {
            wasCreateOrUpdateCalled = true
            completion(.success(CorePayload()))
        }
        
        func lastUpdatedAt<T>(for type: T.Type) -> Date? { nil }
        func url<T>(for type: T.Type) -> URL? { nil }
        func configure() -> URL? { nil }
        func delete() {}
    }
    
    class SeedStoreSpy: SeedStore {
        func configure() {}
        
        func fetch(completion: @escaping (Result<CorePayload, DataError>) -> Void) {
            completion(.success(CorePayload()))
        }
    }
    
    class RemoteStoreSpy: RemoteStore {
        func configure() {}
        
        func fetchLatest(after date: Date?, with request: DataAPI.RemoteRequest, completion: @escaping (Result<CorePayload, DataError>) -> Void) {
            completion(.success(CorePayload()))
        }
    }
}
