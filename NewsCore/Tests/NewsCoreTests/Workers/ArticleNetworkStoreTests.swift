//
//  File.swift
//  
//
//  Created by Basem Emara on 2019-11-18.
//

import XCTest
import NewsCore

final class ArticleNetworkStoreTests: BaseTestCase {
    private lazy var store: ArticleRemote = dependency.resolve()
}

extension ArticleNetworkStoreTests {
    
    func testFetchEverything() {
        // Given
        let promise = expectation(description: "testFetchEverything")
        let request = ArticleAPI.RemoteRequest(
            type: .all()
        )
        
        // When
        store.fetch(with: request) {
            defer { promise.fulfill() }
            
            guard case .success(let value) = $0 else {
                XCTFail("The request for articles failed: \(String(describing: $0.error))")
                return
            }
            
            // Then
            XCTAssertGreaterThan(value.count, 0)
        }
        
        wait(for: [promise], timeout: 10)
    }
    
    func testFetchHeadlines() {
        // Given
        let promise = expectation(description: "testFetchHeadlines")
        let request = ArticleAPI.RemoteRequest(
            type: .headlines()
        )
        
        // When
        store.fetch(with: request) {
            defer { promise.fulfill() }
            
            guard case .success(let value) = $0 else {
                XCTFail("The request for articles failed: \(String(describing: $0.error))")
                return
            }
            
            // Then
            XCTAssertGreaterThan(value.count, 0)
        }
        
        wait(for: [promise], timeout: 10)
    }
}

extension ArticleNetworkStoreTests {
    
    func testFetchEverythingBySource() {
        // Given
        let promise = expectation(description: "testFetchEverythingBySource")
        let sources = ["cbc-news"]
        let request = ArticleAPI.RemoteRequest(
            type: .all(),
            sources: sources
        )
        
        // When
        store.fetch(with: request) {
            defer { promise.fulfill() }
            
            guard case .success(let value) = $0 else {
                XCTFail("The request for articles failed: \(String(describing: $0.error))")
                return
            }
            
            // Then
            XCTAssert(value.allSatisfy { sources.contains($0.source.id ?? "") })
        }
        
        wait(for: [promise], timeout: 10)
    }
    
    func testFetchHeadlinesBySource() {
        // Given
        let promise = expectation(description: "testFetchHeadlinesBySource")
        let sources = ["cbc-news"]
        let request = ArticleAPI.RemoteRequest(
            type: .headlines(),
            sources: sources
        )
        
        // When
        store.fetch(with: request) {
            defer { promise.fulfill() }
            
            guard case .success(let value) = $0 else {
                XCTFail("The request for articles failed: \(String(describing: $0.error))")
                return
            }
            
            // Then
            XCTAssert(value.allSatisfy { sources.contains($0.source.id ?? "") })
        }
        
        wait(for: [promise], timeout: 10)
    }
}

extension ArticleNetworkStoreTests {
    
    func testFetchEverythingFromDate() {
        // Given
        let promise = expectation(description: "testFetchEverythingFromDate")
        let fromDate = Date(timeIntervalSinceNow: -1234567)
        let request = ArticleAPI.RemoteRequest(
            type: .all(from: fromDate)
        )
        
        // When
        store.fetch(with: request) {
            defer { promise.fulfill() }
            
            guard case .success(let value) = $0 else {
                XCTFail("The request for articles failed: \(String(describing: $0.error))")
                return
            }
            
            // Then
            XCTAssert(value.allSatisfy { $0.publishedAt >= fromDate })
        }
        
        wait(for: [promise], timeout: 10)
    }
    
    func testFetchEverythingToDate() {
        // Given
        let promise = expectation(description: "testFetchEverythingToDate")
        let toDate = Date(timeIntervalSinceNow: -1234567)
        let request = ArticleAPI.RemoteRequest(
            type: .all(to: toDate)
        )
        
        // When
        store.fetch(with: request) {
            defer { promise.fulfill() }
            
            guard case .success(let value) = $0 else {
                XCTFail("The request for articles failed: \(String(describing: $0.error))")
                return
            }
            
            // Then
            XCTAssert(value.allSatisfy { $0.publishedAt <= toDate })
        }
        
        wait(for: [promise], timeout: 10)
    }
}
