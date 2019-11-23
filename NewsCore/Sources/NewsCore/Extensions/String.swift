//
//  String.swift
//  NewsCore
//
//  Created by Basem Emara on 2019-11-18.
//

import Foundation

public extension String {
    
    /// Returns the encoded string allowed in a query URL component.
    var urlQueryEncoded: String {
        addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?
            .replacingOccurrences(of: "+", with: "%2B")
                ?? self
    }
}

extension String {
    
    /// Keys for strongly-typed access for User Defaults, Keychain, or custom types.
    ///
    ///     // First define keys
    ///     extension String.Keys {
    ///         static let testString = String.Key<String?>("testString")
    ///         static let testInt = String.Key<Int?>("testInt")
    ///         static let testBool = String.Key<Bool?>("testBool")
    ///         static let testArray = String.Key<[Int]?>("testArray")
    ///     }
    ///
    ///     // Then use strongly-typed values
    ///     let testString: String? = UserDefaults.standard[.testString]
    ///     let testInt: Int? = UserDefaults.standard[.testInt]
    ///     let testBool: Bool? = UserDefaults.standard[.testBool]
    ///     let testArray: [Int]? = UserDefaults.standard[.testArray]
    open class Keys {
        fileprivate init() {}
    }
    
    /// User Defaults key for strongly-typed access.
    open class Key<ValueType>: Keys {
        public let name: String
        
        public init(_ key: String) {
            self.name = key
            super.init()
        }
    }
}
