//
//  NetworkService.swift
//  NewsCore
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
    
    func get(with request: NetworkAPI.Request, completion: @escaping (Result<NetworkAPI.Response, NetworkAPI.Error>) -> Void) {
        store.get(with: request, completion: completion)
    }
    
    func get<T: Decodable>(with request: NetworkAPI.Request, type: T.Type, decoder: JSONDecoder, completion: @escaping (Result<NetworkAPI.DecodedResponse<T>, NetworkAPI.Error>) -> Void) {
        store.get(with: request, type: type, decoder: decoder, completion: completion)
    }
    
    func post(with request: NetworkAPI.Request, completion: @escaping (Result<NetworkAPI.Response, NetworkAPI.Error>) -> Void) {
        store.post(with: request, completion: completion)
    }
    
    func post<T: Decodable>(with request: NetworkAPI.Request, type: T.Type, decoder: JSONDecoder, completion: @escaping (Result<NetworkAPI.DecodedResponse<T>, NetworkAPI.Error>) -> Void) {
        store.post(with: request, type: type, decoder: decoder, completion: completion)
    }
}
