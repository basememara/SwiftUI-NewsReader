//
//  NetworkFoundationStore.swift
//  NewsCore
//
//  Created by Basem Emara on 2019-11-18.
//

import Foundation

public struct NetworkFoundationStore: NetworkStore {}

public extension NetworkFoundationStore {
    
    func get(
        with request: NetworkAPI.Request,
        completion: @escaping (Result<NetworkAPI.Response, NetworkAPI.Error>) -> Void
    ) {
        guard let url = URL(string: request.url) else {
            completion(.failure(NetworkAPI.Error(request: request)))
            return
        }
        
        var urlRequest = URLRequest(
            url: url.appendingQueryItems(request.parameters ?? [:])
        )
        
        urlRequest.httpMethod = "GET"
        urlRequest.timeoutInterval = request.timeoutInterval ?? 10
        
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(
            with: urlRequest,
            original: request,
            completionHandler: completion
        ).resume()
    }
    
    func get<T: Decodable>(
        with request: NetworkAPI.Request,
        type: T.Type,
        decoder: JSONDecoder,
        completion: @escaping (Result<NetworkAPI.DecodedResponse<T>, NetworkAPI.Error>) -> Void
    ) {
        get(with: request) {
            switch $0 {
            case .success(let response):
                self.decode(request, response, type, decoder, completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

public extension NetworkFoundationStore {
    
    func post(
        with request: NetworkAPI.Request,
        completion: @escaping (Result<NetworkAPI.Response, NetworkAPI.Error>) -> Void
    ) {
        guard let url = URL(string: request.url) else {
            completion(.failure(NetworkAPI.Error(request: request)))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.timeoutInterval = request.timeoutInterval ?? 10
        
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let parameters = request.parameters, !parameters.isEmpty {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        
        URLSession.shared.dataTask(
            with: urlRequest,
            original: request,
            completionHandler: completion
        ).resume()
    }
    
    func post<T: Decodable>(
        with request: NetworkAPI.Request,
        type: T.Type,
        decoder: JSONDecoder,
        completion: @escaping (Result<NetworkAPI.DecodedResponse<T>, NetworkAPI.Error>) -> Void
    ) {
        post(with: request) {
            switch $0 {
            case .success(let response):
                self.decode(request, response, type, decoder, completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Helpers

private extension URLSession {
    
    /// Creates a task that retrieves the contents of a URL based on the specified URL request object, and calls a handler upon completion.
    ///
    /// - Parameters:
    ///   - request: A URL request object that provides the URL, cache policy, request type, body data or body stream, and so on.
    ///   - originalRequest: The original network request.
    ///   - completionHandler: The completion handler to call when the load request is complete. This handler is executed on the main queue.
    func dataTask(
        with request: URLRequest,
        original originalRequest: NetworkAPI.Request,
        completionHandler: @escaping (Result<NetworkAPI.Response, NetworkAPI.Error>) -> Void
    ) -> URLSessionDataTask {
        dataTask(with: request) { (data, response, error) in
            if let error = error {
                let networkError = NetworkAPI.Error(request: originalRequest, response: nil, internalError: error)
                DispatchQueue.main.async { completionHandler(.failure(networkError)) }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let networkError = NetworkAPI.Error(request: originalRequest, response: nil, internalError: nil)
                DispatchQueue.main.async { completionHandler(.failure(networkError)) }
                return
            }
            
            let headers: [String: String] = Dictionary(
                uniqueKeysWithValues: httpResponse.allHeaderFields.map { ("\($0)", "\($1)") }
            )
            
            guard let data = data else {
                let networkResponse = NetworkAPI.Response(data: nil, headers: headers, statusCode: httpResponse.statusCode)
                let networkError = NetworkAPI.Error(request: originalRequest, response: networkResponse, internalError: nil)
                DispatchQueue.main.async { completionHandler(.failure(networkError)) }
                return
            }
            
            guard 200..<300 ~= httpResponse.statusCode else {
                let networkResponse = NetworkAPI.Response(data: data, headers: headers, statusCode: httpResponse.statusCode)
                let networkError = NetworkAPI.Error(request: originalRequest, response: networkResponse, internalError: nil)
                DispatchQueue.main.async { completionHandler(.failure(networkError)) }
                return
            }
            
            DispatchQueue.main.async {
                let networkResponse = NetworkAPI.Response(data: data, headers: headers, statusCode: httpResponse.statusCode)
                completionHandler(.success(networkResponse))
            }
        }
    }
}

private extension NetworkFoundationStore {
    
    /// Decodes a response.
    func decode<T: Decodable>(
        _ request: NetworkAPI.Request,
        _ response: NetworkAPI.Response,
        _ type: T.Type,
        _ decoder: JSONDecoder,
        _ completion: @escaping (Result<NetworkAPI.DecodedResponse<T>, NetworkAPI.Error>) -> Void
    ) {
        guard let data = response.data else {
            // No data was found in the response
            let error = NetworkAPI.Error(
                request: request,
                response: response,
                internalError: DataError.parseFailure(nil)
            )
            
            completion(.failure(error))
            return
        }
        
        DispatchQueue.transform.async {
            do {
                let decodedResponse = NetworkAPI.DecodedResponse(
                    model: try decoder.decode(type, from: data),
                    headers: response.headers,
                    statusCode: response.statusCode
                )
                
                DispatchQueue.main.async {
                    completion(.success(decodedResponse))
                }
            } catch {
                let error = NetworkAPI.Error(
                    request: request,
                    response: response,
                    internalError: DataError.parseFailure(nil)
                )
                
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }
}
