//
//  CacheDiskStoreTests.swift
//  NewsCoreTests
//
//  Created by Basem Emara on 2019-11-18.
//

import XCTest
@testable import NewsCore

final class CacheDiskStoreTests: BaseTestCase {
    private lazy var store: CacheStore = config.dependency()
    private lazy var dataWorker: DataWorkerType = config.dependency()
    private lazy var fileManager: FileManager = config.dependency()
}

extension CacheDiskStoreTests {
    
    func testConfigureCreatesDirectory() {
        // Given
        guard let directoryURL = store.configure() else {
            XCTFail("Could not resolve cache directory.")
            return
        }
        
        // Then
        XCTAssert(fileManager.fileExists(atPath: directoryURL.path))
    }
}

extension CacheDiskStoreTests {
    
    func testLastModifiedDateAfterUpdate() {
        // Given
        let promise = expectation(description: "testLastModifiedDateAfterUpdate")
        let date = Date(timeIntervalSinceNow: -1234567)
        let request = DataAPI.CacheRequest(
            payload: CorePayload(
                articles: [
                    Article(
                        url: "https://example.com",
                        title: "Testing Last Updated At",
                        content: nil,
                        excerpt: nil,
                        image: nil,
                        author: nil,
                        publishedAt: date,
                        source: ArticleSource(id: "1", name: "Test")
                    )
                ]
            ),
            lastUpdatedAt: date
        )
        
        // When
        store.createOrUpdate(with: request) { [weak self] in
            defer { promise.fulfill() }
            
            guard let self = self, case .success = $0 else {
                XCTFail("Could not update cache file.")
                return
            }
            
            guard let lastUpdatedAt = self.store.lastUpdatedAt else {
                XCTFail("Could not get modification date of cache file.")
                return
            }
            
            // Then
            XCTAssertEqual(request.lastUpdatedAt, lastUpdatedAt)
        }
        
        wait(for: [promise], timeout: 10)
    }
}

extension CacheDiskStoreTests {
    
    func testCreateOrUpdateArticles() {
        // Given
        let promise = expectation(description: "testCreateOrUpdateArticles")
        let articleURL = "https://example.com"
        let request = DataAPI.CacheRequest(
            payload: CorePayload(
                articles: [
                    Article(
                        url: articleURL,
                        title: "Testing Create or Update",
                        content: nil,
                        excerpt: nil,
                        image: nil,
                        author: nil,
                        publishedAt: Date(),
                        source: ArticleSource(id: "1", name: "Test")
                    )
                ]
            ),
            lastUpdatedAt: Date()
        )
        
        // When
        store.createOrUpdate(with: request) { [weak self] in
            guard let self = self, case .success = $0 else {
                XCTFail("Could not update cache file.")
                promise.fulfill()
                return
            }
            
            let articleCache: ArticleCache = self.config.dependency()
            
            articleCache.fetch(with: .init()) {
                defer { promise.fulfill() }
                
                guard case .success(let value) = $0 else {
                    XCTFail("Could not retrieve cached articles: \(String(describing: $0.error))")
                    return
                }
                
                // Then
                XCTAssertEqual(value.count, 1)
                XCTAssertEqual(value.first?.url, articleURL)
            }
        }
        
        wait(for: [promise], timeout: 10)
    }
}

extension CacheDiskStoreTests {
    
    func testDelete() {
        // Given
        let promise = expectation(description: "testCreateOrUpdateArticles")
        
        guard let url = store.configure() else {
            XCTFail("Could not locate cache directory.")
            promise.fulfill()
            return
        }
        
        dataWorker.pull { [weak self] in
            defer { promise.fulfill() }
            
            guard let self = self, case .success = $0 else {
                XCTFail("Could not update data: \(String(describing: $0.error))")
                return
            }
            
            var fileURLs: [URL] {
                (try? self.fileManager.contentsOfDirectory(
                    at: url,
                    includingPropertiesForKeys: nil,
                    options: .skipsHiddenFiles
                )) ?? []
            }
            
            XCTAssert(!fileURLs.isEmpty) // Should not be empty after pull
            
            // When
            self.store.delete()
            
            // Then
            XCTAssert(fileURLs.isEmpty)
        }
        
        wait(for: [promise], timeout: 10)
    }
}
