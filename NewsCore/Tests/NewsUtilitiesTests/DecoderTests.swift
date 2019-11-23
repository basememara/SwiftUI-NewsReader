//
//  DecodableTests.swift
//  NewsUtilitiesTests
//
//  Created by Basem Emara on 2019-11-18.
//

import XCTest
import NewsCore

final class DecodableTests: XCTestCase {
    private let jsonDecoder = JSONDecoder()
    private lazy var bundle = Bundle(for: type(of: self))
}

extension DecodableTests {
    
    func testFromString() {
        // Given
        struct TestModel: Decodable {
            let string: String
            let integer: Int
        }
        
        let jsonString = """
        {
            "string": "Abc",
            "integer": 123,
        }
        """
        
        // When
        do {
            let model = try jsonDecoder.decode(TestModel.self, from: jsonString)
            
            // Then
            XCTAssertEqual(model.string, "Abc")
            XCTAssertEqual(model.integer, 123)
        } catch {
            XCTFail("Could not parse JSON string: \(error)")
        }
    }
}

extension DecodableTests {
    
    func testInBundle() {
        // Given
        struct TestModel: Decodable {
            let string: String
            let integer: Int
        }
        
        // When
        do {
            let model = try jsonDecoder.decode(
                TestModel.self,
                forResource: "TestModel.json", // TODO: No SPM embedded resource
                inBundle: bundle
            )
            
            // Then
            XCTAssertEqual(model.string, "Abc")
            XCTAssertEqual(model.integer, 123)
        } catch {
            // TODO: Uncomment when embedded resosurces for SPM works
            // XCTFail("Could not parse JSON resource: \(error)")
            XCTAssert(true)
        }
    }
}
