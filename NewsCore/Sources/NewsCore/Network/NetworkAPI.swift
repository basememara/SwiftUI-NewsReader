//
//  File.swift
//  
//
//  Created by Basem Emara on 2019-11-19.
//

import Foundation

// Namespace for module
public enum NetworkAPI {}

public protocol NetworkStore {
    func get(with request: NetworkAPI.Request, completion: @escaping (Result<Data, NetworkAPI.Error>) -> Void)
    func post(with request: NetworkAPI.Request, completion: @escaping (Result<Data, NetworkAPI.Error>) -> Void)
}

public protocol NetworkServiceType {
    
    /// Creates a task that retrieves the contents of a URL based on the specified GET request object, and calls a handler upon completion.
    /// - Parameters:
    ///   - request: A network request object that provides the URL, parameters, headers, and so on.
    ///   - completion: The completion handler to call when the load request is complete.
    func get(with request: NetworkAPI.Request, completion: @escaping (Result<Data, NetworkAPI.Error>) -> Void)
    
    /// Creates a task that retrieves the contents of a URL based on the specified POST request object, and calls a handler upon completion.
    /// - Parameters:
    ///   - request: A network request object that provides the URL, parameters, headers, and so on.
    ///   - completion: The completion handler to call when the load request is complete.
    func post(with request: NetworkAPI.Request, completion: @escaping (Result<Data, NetworkAPI.Error>) -> Void)
}

// MARK: - Requests/Responses

public extension NetworkAPI {
    
    struct Request {
        let url: String
        let parameters: [String: Any]?
        let headers: [String: String]?
        let timeoutInterval: TimeInterval?
        
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
        let data: Data?
        let headers: [String: String]
        let statusCode: Int
    }
}

public extension NetworkAPI {
    
    struct Error: Swift.Error {
        public let code: String
        public let message: String
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
            
            // Transient model for parsing
            struct ServerResponse: Decodable {
                let code: String
                let message: String
            }
            
            if let data = response?.data,
                let payload = try? JSONDecoder.default.decode(
                    ServerResponse.self,
                    from: data
                ) {
                self.code = payload.code
                self.message = payload.message
            } else {
                self.code = ""
                self.message = ""
            }
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
            code: \(code),
            message: \(message),
            status: \(response?.statusCode ?? 0)
        }
        """
    }
}
