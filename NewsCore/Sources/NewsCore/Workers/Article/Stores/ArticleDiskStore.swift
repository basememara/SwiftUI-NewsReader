//
//  File.swift
//  
//
//  Created by Basem Emara on 2019-11-13.
//

import Foundation

public struct ArticleDiskStore: ArticleCache {
    private let store: CacheStore
    private let fileManager: FileManager
    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder
    private let constants: ConstantsType
    private let log: LogWorkerType
    
    public init(
        store: CacheStore,
        fileManager: FileManager,
        jsonDecoder: JSONDecoder,
        jsonEncoder: JSONEncoder,
        constants: ConstantsType,
        log: LogWorkerType
    ) {
        self.store = store
        self.fileManager = fileManager
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
        self.constants = constants
        self.log = log
    }
}

public extension ArticleDiskStore {
    
    func fetch(with request: ArticleAPI.CacheRequest, completion: @escaping (Result<[Article], DataError>) -> Void) {
        DispatchQueue.transform.async {
            do {
                guard let url = self.store.url(for: Article.self) else {
                    DispatchQueue.main.async { completion(.failure(.cacheFailure(nil))) }
                    return
                }
                
                guard let data = self.fileManager.contents(atPath: url.path) else {
                    DispatchQueue.main.async { completion(.success([])) }
                    return
                }
                
                let models = try self.jsonDecoder.decode([Article].self, from: data)
                DispatchQueue.main.async { completion(.success(models)) }
            } catch {
                self.log.error("An error occured while retrieving the articles from cache: \(error).")
                DispatchQueue.main.async { completion(.failure(.parseFailure(error))) }
                return
            }
        }
    }
}

public extension ArticleDiskStore {
    
    func fetch(url: String, completion: @escaping (Result<Article, DataError>) -> Void) {
        // TODO: Optimize lookup
        fetch(with: .init()) {
            guard case .success(let value) = $0 else {
                completion(.failure($0.error ?? .unknownReason(nil)))
                return
            }
            
            guard let model = value.first(where: { $0.url == url }) else {
                completion(.failure(.nonExistent))
                return
            }
            
            completion(.success(model))
        }
    }
}

public extension ArticleDiskStore {
    
    func createOrUpdate(_ request: Article, completion: @escaping (Result<Article, DataError>) -> Void) {
        DispatchQueue.database.async {
            do {
                guard let url = self.store.url(for: Article.self),
                    let data = self.fileManager.contents(atPath: url.path) else {
                        completion(.failure(.cacheFailure(nil)))
                        return
                }
                
                let previousModels = try self.jsonDecoder.decode([Article].self, from: data)
                
                self.fileManager.createFile(
                    atPath: url.path,
                    contents: try self.jsonEncoder.encode(
                        // TODO: Optimize using `Identifiable` and `Set`?
                        previousModels.filter { $0.id != request.id } + [request]
                    )
                )
            } catch {
                self.log.error("Could not write article to cache: \(error)")
                DispatchQueue.main.async { completion(.failure(.cacheFailure(error))) }
                return
            }
        }
    }
}
