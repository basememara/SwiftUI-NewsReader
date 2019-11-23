//
//  NetworkServiceTests.swift
//  NewsCoreTests
//
//  Created by Basem Emara on 2019-11-18.
//

import XCTest
import NewsCore

final class NetworkServiceTests: BaseTestCase {
    private lazy var service: NetworkServiceType = dependency.resolve()
    private lazy var constants: ConstantsType = dependency.resolve()
}

extension NetworkServiceTests {
    
    func testNetworkResponse() {
        // Given
        let promise = expectation(description: "testNetworkResponse")
        let request = NetworkAPI.Request(
            url: constants.baseURL
                .appendingPathComponent(constants.baseREST)
                .appendingPathComponent("top-headlines")
                .absoluteString,
            parameters: [
                "country": "ca",
                "apiKey": constants.newsAPIKey
            ]
        )
        
        // When
        service.get(with: request) {
            defer { promise.fulfill() }
            
            guard case .success(let value) = $0 else {
                XCTFail("The network request failed: \(String(describing: $0.error))")
                return
            }
            
            do {
                // Transient model for parsing
                struct ServerResponse: Decodable {
                    let totalResults: Int
                    let articles: [Article]
                }
                
                let payload = try JSONDecoder.default.decode(ServerResponse.self, from: value)
                
                // Then
                XCTAssertGreaterThan(payload.articles.count, 0)
            } catch {
                XCTFail("Parsing server data failed: \(error)")
                return
            }
        }
        
        wait(for: [promise], timeout: 10)
    }
}
