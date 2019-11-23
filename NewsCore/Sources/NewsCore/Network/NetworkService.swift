//
//  File.swift
//  
//
//  Created by Basem Emara on 2019-11-21.
//

import Foundation

public struct NetworkService: NetworkServiceType {
    private let store: NetworkStore
    
    init(store: NetworkStore) {
        self.store = store
    }
}

public extension NetworkService {
    
    func get(with request: NetworkAPI.Request, completion: @escaping (Result<Data, NetworkAPI.Error>) -> Void) {
        store.get(with: request, completion: completion)
    }
    
    func post(with request: NetworkAPI.Request, completion: @escaping (Result<Data, NetworkAPI.Error>) -> Void) {
        store.post(with: request, completion: completion)
    }
}
