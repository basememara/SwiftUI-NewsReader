//
//  BaseTestCase.swift
//  NewsCoreTests
//
//  Created by Basem Emara on 2019-11-19.
//

import XCTest
import NewsCore

class BaseTestCase: XCTestCase {
    private lazy var dataProvider: DataProviderType = core.dependency()
    private lazy var preferences: PreferencesType = core.dependency()
    
    lazy var core: NewsCore = TestsCore()
    
    override func setUp() {
        super.setUp()
        
        // Clear previous
        dataProvider.reset()
        preferences.removeAll()
        UserDefaults.test.removeAll()
        
        // Setup database
        dataProvider.configure()
    }
}
