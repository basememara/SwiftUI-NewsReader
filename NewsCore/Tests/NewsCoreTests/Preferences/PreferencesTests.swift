//
//  File.swift
//  
//
//  Created by Basem Emara on 2019-11-18.
//

import XCTest
import NewsCore

final class PreferencesTests: BaseTestCase {
    private lazy var preferences: PreferencesType = dependency.resolve()
}

extension PreferencesTests {
    
    func testUserDefaults() {
        preferences.set("abc", forKey: .testString1)
        preferences.set("xyz", forKey: .testString2)
        preferences.set(true, forKey: .testBool1)
        preferences.set(false, forKey: .testBool2)
        preferences.set(123, forKey: .testInt1)
        preferences.set(987, forKey: .testInt2)
        preferences.set(1.1, forKey: .testFloat1)
        preferences.set(9.9, forKey: .testFloat2)
        preferences.set([1, 2, 3], forKey: .testArray)
        
        XCTAssertEqual(preferences.get(.testString1), "abc")
        XCTAssertEqual(preferences.get(.testString2), "xyz")
        XCTAssert(preferences.get(.testBool1))
        XCTAssertFalse(preferences.get(.testBool2))
        XCTAssertEqual(preferences.get(.testInt1), 123)
        XCTAssertEqual(preferences.get(.testInt2), 987)
        XCTAssertEqual(preferences.get(.testFloat1), 1.1)
        XCTAssertEqual(preferences.get(.testFloat2), 9.9)
        XCTAssertEqual(preferences.get(.testArray), [1, 2, 3])
    }
}

private extension String.Keys {
    static let testString1 = String.Key<String?>("testString1")
    static let testString2 = String.Key<String?>("testString2")
    static let testBool1 = String.Key<Bool?>("testBool1")
    static let testBool2 = String.Key<Bool?>("testBool2")
    static let testInt1 = String.Key<Int?>("testInt1")
    static let testInt2 = String.Key<Int?>("testInt2")
    static let testFloat1 = String.Key<Float?>("testFloat1")
    static let testFloat2 = String.Key<Float?>("testFloat2")
    static let testArray = String.Key<[Int]?>("testArray")
}
