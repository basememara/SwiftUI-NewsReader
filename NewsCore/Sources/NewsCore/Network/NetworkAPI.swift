//
//  NetworkAPI.swift
//  NewsCore
//
//  Created by Basem Emara on 2019-11-19.
//

import Foundation

// Namespace
public enum NetworkAPI {}

public protocol NetworkStore {
    func get(with request: NetworkAPI.Request, completion: @escaping (Result<NetworkAPI.Response, NetworkAPI.Error>) -> Void)
    func get<T: Decodable>(with request: NetworkAPI.Request, type: T.Type, decoder: JSONDecoder, completion: @escaping (Result<NetworkAPI.DecodedResponse<T>, NetworkAPI.Error>) -> Void)
    func post(with request: NetworkAPI.Request, completion: @escaping (Result<NetworkAPI.Response, NetworkAPI.Error>) -> Void)
    func post<T: Decodable>(with request: NetworkAPI.Request, type: T.Type, decoder: JSONDecoder, completion: @escaping (Result<NetworkAPI.DecodedResponse<T>, NetworkAPI.Error>) -> Void)
}

public protocol NetworkServiceType {
    
    /// Creates a task that retrieves the contents of a URL based on the specified GET request object, and calls a handler upon completion.
    ///
    /// - Parameters:
    ///   - request: A network request object that provides the URL, parameters, headers, and so on.
    ///   - completion: The completion handler to call when the load request is complete.
    func get(with request: NetworkAPI.Request, completion: @escaping (Result<NetworkAPI.Response, NetworkAPI.Error>) -> Void)
    
    /// Creates a task that retrieves the decoded contents of a URL based on the specified GET request object, and calls a handler upon completion.
    ///
    /// - Parameters:
    ///   - request: A network request object that provides the URL, parameters, headers, and so on.
    ///   - type: The type of the response data to decode.
    ///   - decoder: The decoder to use for parsing the codable response.
    ///   - completion: The completion handler to call when the load request is complete.
    func get<T: Decodable>(with request: NetworkAPI.Request, type: T.Type, decoder: JSONDecoder, completion: @escaping (Result<NetworkAPI.DecodedResponse<T>, NetworkAPI.Error>) -> Void)
    
    /// Creates a task that retrieves the contents of a URL based on the specified POST request object, and calls a handler upon completion.
    /// 
    /// - Parameters:
    ///   - request: A network request object that provides the URL, parameters, headers, and so on.
    ///   - completion: The completion handler to call when the load request is complete.
    func post(with request: NetworkAPI.Request, completion: @escaping (Result<NetworkAPI.Response, NetworkAPI.Error>) -> Void)
    
    /// Creates a task that retrieves the decoded contents of a URL based on the specified POST request object, and calls a handler upon completion.
    ///
    /// - Parameters:
    ///   - request: A network request object that provides the URL, parameters, headers, and so on.
    ///   - type: The type of the response data to decode.
    ///   - decoder: The decoder to use for parsing the codable response.
    ///   - completion: The completion handler to call when the load request is complete.
    func post<T: Decodable>(with request: NetworkAPI.Request, type: T.Type, decoder: JSONDecoder, completion: @escaping (Result<NetworkAPI.DecodedResponse<T>, NetworkAPI.Error>) -> Void)
}

// MARK: - Requests/Responses

public extension NetworkAPI {
    
    struct Request {
        public let url: String
        public let parameters: [String: Any]?
        public let headers: [String: String]?
        public let timeoutInterval: TimeInterval?
        
        public init(
            url: String,
            parameters: [String: Any]? = nil,
            headers: [String: String]? = nil,
            timeoutInterval: TimeInterval? = nil
        ) {
            self.url = url
            self.parameters = parameters
            self.headers = headers
            self.timeoutInterval = timeoutInterval
        }
    }
    
    struct Response {
        public let data: Data?
        public let headers: [String: String]
        public let statusCode: Int
    }
    
    struct DecodedResponse<T: Decodable> {
        public let model: T
        public let headers: [String: String]
        public let statusCode: Int
    }
}

public extension NetworkAPI {
    
    struct Error: Swift.Error {
        public let request: Request?
        public let response: Response?
        public let internalError: Swift.Error?
        
        /// The initializer for the network error type.
        ///
        /// - Parameters:
        ///   - code: The error code from the server.
        ///   - message: The friendly error message from the server.
        ///   - request: The original request that initiated the task.
        ///   - response: The response from the server.
        ///   - internalError: The internal error from the network request.
        init(
            request: Request? = nil,
            response: Response? = nil,
            internalError: Swift.Error? = nil
        ) {
            self.request = request
            self.response = response
            self.internalError = internalError
        }
    }
}

extension NetworkAPI.Error: CustomStringConvertible {
    
    public var description: String {
        """
        \(internalError ?? DataError.unknownReason(nil))
        Request: {
            url: \(request?.url ?? "")
        },
        Response: {
            status: \(response?.statusCode ?? 0)
        }
        """
    }
}
