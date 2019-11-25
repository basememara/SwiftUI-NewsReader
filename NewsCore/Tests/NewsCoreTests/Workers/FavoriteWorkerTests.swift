//
//  File.swift
//  
//
//  Created by Basem Emara on 2019-11-24.
//

import XCTest
import NewsCore

final class FavoriteWorkerTests: BaseTestCase {
    private lazy var worker: FavoriteWorkerType = config.dependency()
}

extension FavoriteWorkerTests {
    
    func testAddingFavorites() {
        // Given
        let articleID = "Abc"
        
        // When
        worker.addArticle(id: articleID)
        
        // Then
        XCTAssert(worker.hasArticle(id: articleID))
    }
}
