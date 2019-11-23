//
//  File.swift
//  
//
//  Created by Basem Emara on 2019-11-19.
//

import XCTest
import NewsCore

class BaseTestCase: XCTestCase {
    private lazy var dataWorker: DataWorkerType = dependency.resolve()
    private lazy var preferences: PreferencesType = dependency.resolve()
    
    lazy var dependency: NewsCoreDependency = TestsDependency()
    
    override func setUp() {
        super.setUp()
        
        // Clear previous
        dataWorker.reset()
        preferences.removeAll()
        UserDefaults.test.removeAll()
        
        // Setup database
        dataWorker.configure()
    }
}
