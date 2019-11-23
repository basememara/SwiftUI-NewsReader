//
//  DataWorker.swift
//  NewsCore
//
//  Created by Basem Emara on 2019-11-18.
//

import Foundation

public struct DataWorker: DataWorkerType {
    private let constants: ConstantsType
    private let cacheStore: CacheStore
    private let seedStore: SeedStore
    private let remoteStore: RemoteStore
    private let log: LogWorkerType
    
    init(constants: ConstantsType, cacheStore: CacheStore, seedStore: SeedStore, remoteStore: RemoteStore, log: LogWorkerType) {
        self.constants = constants
        self.cacheStore = cacheStore
        self.seedStore = seedStore
        self.remoteStore = remoteStore
        self.log = log
    }
}

public extension DataWorker {
    
    func configure() {
        cacheStore.configure()
        seedStore.configure()
        remoteStore.configure()
    }
    
    func reset() {
        cacheStore.delete()
    }
}

public extension DataWorker {
    // Handle simultanuous update requests in a queue
    private static let queue = DispatchQueue(label: "\(DispatchQueue.labelPrefix).DataWorker.sync")
    private static var tasks = [((Result<CorePayload, DataError>) -> Void)]()
    private static var isUpdating = false
    
    func pull(completion: ((Result<CorePayload, DataError>) -> Void)?) {
        Self.queue.async {
            if let completion = completion {
                Self.tasks.append(completion)
            }
            
            guard !Self.isUpdating else {
                self.log.info("Data pull already in progress, queuing...")
                return
            }
            
            Self.isUpdating = true
            self.log.info("Data pull requested...")
            
            // Determine if cache seeded before or just get latest from remote
            guard let lastUpdatedAt = self.cacheStore.lastUpdatedAt else {
                self.log.info("Seeding cache storage first time begins...")
                self.seedFromLocal()
                return
            }
            
            self.log.info("Write remote into cache storage begins, last updated at \(lastUpdatedAt)...")
            self.seedFromRemote(after: lastUpdatedAt)
        }
    }
}

// MARK: - Helpers

private extension DataWorker {
    
    func seedFromLocal() {
        seedStore.fetch {
            guard case .success(let local) = $0, !local.isEmpty else {
                self.log.error("Failed to retrieve seed data, falling back to remote server...")
                
                let request = DataAPI.RemoteRequest()
                
                self.remoteStore.fetchLatest(after: nil, with: request) {
                    guard case .success(let value) = $0 else {
                        self.executeTasks($0)
                        return
                    }
                    
                    self.log.debug("Found \(value.articles.count) articles to remotely write into cache storage.")
                    
                    let request = DataAPI.CacheRequest(payload: value, lastUpdatedAt: Date())
                    self.cacheStore.createOrUpdate(with: request, completion: self.executeTasks)
                }
                
                return
            }
            
            self.log.debug("Found \(local.articles.count) articles to seed into cache storage.")
            
            let lastSeedDate = local.articles.compactMap { $0.publishedAt }.max() ?? Date()
            let request = DataAPI.CacheRequest(payload: local, lastUpdatedAt: lastSeedDate)
            
            self.cacheStore.createOrUpdate(with: request) {
                guard case .success = $0 else {
                    self.executeTasks($0)
                    return
                }
                
                self.log.debug("Seeding cache storage complete, now updating from remote storage.")
                
                // Fetch latest beyond seed
                let request = DataAPI.RemoteRequest()
                
                self.remoteStore.fetchLatest(after: lastSeedDate, with: request) {
                    guard case .success(let remote) = $0 else {
                        self.executeTasks(.success(local))
                        return
                    }
                    
                    self.log.debug("Found \(remote.articles.count) articles to remotely write into cache storage.")
                    let request = DataAPI.CacheRequest(payload: remote, lastUpdatedAt: Date())
                    
                    self.cacheStore.createOrUpdate(with: request) {
                        guard case .success = $0 else {
                            self.executeTasks(.success(local))
                            return
                        }
                        
                        let combinedPayload = CorePayload(
                            articles: local.articles + remote.articles
                        )
                        
                        self.log.debug("Seeded \(local.articles.count) articles from local "
                            + "and \(remote.articles.count) articles from remote into cache storage.")
                        
                        self.executeTasks(.success(combinedPayload))
                    }
                }
            }
        }
    }
}

private extension DataWorker {
    
    func seedFromRemote(after date: Date) {
        let request = DataAPI.RemoteRequest()
        
        remoteStore.fetchLatest(after: date, with: request) {
            guard case .success(let value) = $0 else {
                self.executeTasks($0)
                return
            }
            
            self.log.debug("Found \(value.articles.count) articles to remotely write into cache storage.")
            
            let request = DataAPI.CacheRequest(payload: value, lastUpdatedAt: Date())
            self.cacheStore.createOrUpdate(with: request, completion: self.executeTasks)
        }
    }
}

private extension DataWorker {
    
    func executeTasks(_ result: Result<CorePayload, DataError>) {
        Self.queue.async {
            let tasks = Self.tasks
            Self.tasks.removeAll()
            Self.isUpdating = false
            
            self.log.info("Data pull request complete, now executing \(tasks.count) queued tasks...")
            
            DispatchQueue.main.async {
                tasks.forEach { $0(result) }
            }
        }
    }
}
