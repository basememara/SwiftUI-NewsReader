//
//  BaseTestCase.swift
//  NewsCoreTests
//
//  Created by Basem Emara on 2019-11-19.
//

import XCTest
import NewsCore

class BaseTestCase: XCTestCase {
    private lazy var dataWorker: DataWorkerType = config.dependency()
    private lazy var preferences: PreferencesType = config.dependency()
    
    lazy var config: NewsCoreConfig = TestsConfig()
    
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
