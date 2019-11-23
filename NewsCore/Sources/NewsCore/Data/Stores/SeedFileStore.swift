//
//  SeedFileStore.swift
//
//  Created by Basem Emara on 2019-11-18.
//

import Foundation

public struct SeedFileStore: SeedStore {
    private static var data: CorePayload?
    
    private let name: String
    private let bundle: Bundle
    private let jsonDecoder: JSONDecoder
    
    public init(
        forResource name: String,
        inBundle bundle: Bundle,
        jsonDecoder: JSONDecoder
    ) {
        self.name = name
        self.bundle = bundle
        self.jsonDecoder = jsonDecoder
    }
}

public extension SeedFileStore {
    
    func configure() {
        guard Self.data == nil else { return }
        
        Self.data = try? jsonDecoder.decode(
            CorePayload.self,
            forResource: name,
            inBundle: bundle
        )
    }
}

public extension SeedFileStore {
    
    func fetch(completion: @escaping (Result<CorePayload, DataError>) -> Void) {
        completion(.success(Self.data ?? CorePayload()))
    }
}

public extension SeedFileStore {
    
    func set(data: CorePayload) {
        Self.data = data
    }
}
