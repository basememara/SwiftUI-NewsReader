//
//  Extensions.swift
//  NewsCoreTests
//
//  Created by Basem Emara on 2019-11-19.
//

import Foundation
import XCTest

extension UserDefaults {
    static let test = UserDefaults(suiteName: Bundle.test.bundleIdentifier!)!
}

extension Bundle {
    private class TempClassForBundle {}
    
    /// A representation of the code and resources stored in bundle directory on disk.
    static let test = Bundle(for: TempClassForBundle.self)
}
