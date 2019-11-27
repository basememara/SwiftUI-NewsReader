//
//  File.swift
//  
//
//  Created by Basem Emara on 2019-11-24.
//

import XCTest
import NewsCore

final class FavoriteProviderTests: BaseTestCase {
    private lazy var provider: FavoriteProviderType = core.dependency()
}

extension FavoriteProviderTests {
    
    func testAddingFavorites() {
        // Given
        let articleID = "Abc"
        
        // When
        provider.addArticle(id: articleID)
        
        // Then
        XCTAssert(provider.hasArticle(id: articleID))
    }
}
