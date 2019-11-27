//
//  DataProviderTests.swift
//  NewsCoreTests
//
//  Created by Basem Emara on 2019-11-18.
//

import XCTest
@testable import NewsCore

final class DataProviderTests: BaseTestCase {
    private lazy var provider: DataProviderType = core.dependency()
    
    override func setUp() {
        super.setUp()
        
        core = LocalConfig()
        provider.configure()
    }
}

extension DataProviderTests {
    
    func testFlowOfStores() {
        // Given
        let promise = expectation(description: "testFlowOfStores")
        
        // When
        provider.pull {
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

private extension DataProviderTests {
    
    struct LocalConfig: NewsCore {
        
        func dependencyStore() -> ConstantsStore {
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
        
        func dependencyStore() -> PreferencesStore {
            PreferencesDefaultsStore(defaults: .test)
        }
        
        func dependency() -> CacheStore {
            CacheStoreSpy()
        }
        
        func dependency() -> SeedStore {
            SeedStoreSpy()
        }
        
        func dependency() -> RemoteStore {
            RemoteStoreSpy()
        }
        
        func dependency() -> [LogStore] {
            [LogConsoleStore(minLevel: .verbose)]
        }
        
        func dependency() -> Theme {
            fatalError("Not implemented")
        }
    }
}

private extension DataProviderTests {
    
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
