//
//  ArticleNetworkStore.swift
//  NewsCore
//
//  Created by Basem Emara on 2019-11-13.
//

import Foundation

public struct ArticleNetworkStore: ArticleRemote {
    private let networkService: NetworkServiceType
    private let jsonDecoder: JSONDecoder
    private let constants: ConstantsType
    private let log: LogProviderType
    
    public init(
        networkService: NetworkServiceType,
        jsonDecoder: JSONDecoder,
        constants: ConstantsType,
        log: LogProviderType
    ) {
        self.networkService = networkService
        self.jsonDecoder = jsonDecoder
        self.constants = constants
        self.log = log
    }
}

public extension ArticleNetworkStore {
    
    func fetch(with request: ArticleAPI.RemoteRequest, completion: @escaping (Result<[Article], DataError>) -> Void) {
        let type: String = {
            switch request.type {
            case .all:
                return "everything"
            case .headlines:
                return "top-headlines"
            }
        }()
        
        let request = NetworkAPI.Request(
            url: constants.baseURL
                .appendingPathComponent(constants.baseREST)
                .appendingPathComponent(type)
                .absoluteString,
            parameters: request.parameters(with: constants),
            headers: ["X-Api-Key": constants.newsAPIKey]
        )
        
        // Transient model for parsing
        struct ServerResponse: Decodable {
            let totalResults: Int
            let articles: [Article]
        }
        
        networkService.get(with: request, type: ServerResponse.self, decoder: jsonDecoder) {
            guard case .success(let response) = $0 else {
                // Handle no modified data and return success
                if $0.error?.response?.statusCode == 304 {
                    completion(.success([]))
                    return
                }
                
                self.log.error("An error occured while fetching the articles: \(String(describing: $0.error)).")
                completion(.failure(DataError(from: $0.error)))
                return
            }
            
            completion(.success(response.model.articles))
        }
    }
}

// MARK: - Helpers

private extension ArticleAPI.RemoteRequest {
    static let dateFormatter = DateFormatter(iso8601Format: "yyyy-MM-dd'T'HH:mm:ss")
    
    /// Constructs the parameters from the request.
    func parameters(with constants: ConstantsType) -> [String: Any] {
        var params: [String: Any] = [:]
        
        // Handle search query
        switch query {
        case .all(let query):
            params["q"] = query.urlQueryEncoded
        case .title(let query):
            params["qInTitle"] = query.urlQueryEncoded
        default:
            break
        }
        
        if let sources = sources, !sources.isEmpty {
            params["sources"] = sources
                .prefix(20) // Max allowed
                .joined(separator: ",")
        }
        
        if let pageSize = pageSize {
            params["pageSize"] = pageSize
        }
        
        if let pageIndex = pageIndex {
            params["page"] = pageIndex
        }
        
        // Handle type of articles requested
        switch type {
        case .all(let from, let to, let language):
            if let date = from {
                params["from"] = Self.dateFormatter.string(from: date)
            }
            
            if let date = to {
                params["to"] = Self.dateFormatter.string(from: date)
            }
            
            if let language = language ?? Locale.current.languageCode {
                params["language"] = language
            }
            
            // Request too broad so narrow it down for server
            if query == nil && sources == nil {
                params["sources"] = constants.defaultFetchSources
                    .prefix(20) // Max allowed
                    .joined(separator: ",")
            }
        case .headlines(let category, let country):
            if let category = category?.rawValue {
                params["category"] = category
            }
            
            if let country = country {
                params["country"] = country
            }
            
            if query == nil
                && sources == nil
                && category == nil
                && country == nil
                && category == nil {
                    params["country"] = Locale.current.regionCode
            }
        }
        
        return params
    }
}
