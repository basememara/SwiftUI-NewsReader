//
//  NetworkServiceTests.swift
//  NewsCoreTests
//
//  Created by Basem Emara on 2019-11-18.
//

import XCTest
import NewsCore

final class NetworkServiceTests: BaseTestCase {
    private let jsonDecoder: JSONDecoder = .default
    
    private lazy var service: NetworkServiceType = core.dependency()
    private lazy var constants: ConstantsType = core.dependency()
}

extension NetworkServiceTests {
    
    func testNetworkResponse() {
        // Given
        let promise = expectation(description: #function)
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
            
            guard case .success(let response) = $0 else {
                XCTFail("The network request failed: \(String(describing: $0.error))")
                return
            }
            
            guard let data = response.data else {
                XCTFail("No data was found in the response")
                return
            }
            
            do {
                // Transient model for parsing
                struct ServerResponse: Decodable {
                    let totalResults: Int
                    let articles: [Article]
                }
                
                let payload = try self.jsonDecoder.decode(ServerResponse.self, from: data)
                
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

extension NetworkServiceTests {
    
    func testNetworkDecodedResponse() {
        // Given
        let promise = expectation(description: #function)
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
        
        // Transient model for parsing
        struct ServerResponse: Decodable {
            let totalResults: Int
            let articles: [Article]
        }
        
        // When
        service.get(with: request, type: ServerResponse.self, decoder: jsonDecoder) {
            defer { promise.fulfill() }
            
            guard case .success(let response) = $0 else {
                XCTFail("The network request failed: \(String(describing: $0.error))")
                return
            }
    
            // Then
            XCTAssertGreaterThan(response.model.articles.count, 0)
        }
        
        wait(for: [promise], timeout: 10)
    }
}
