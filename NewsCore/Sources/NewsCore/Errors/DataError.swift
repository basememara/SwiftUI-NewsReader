//
//  File.swift
//  
//
//  Created by Basem Emara on 2019-11-17.
//

import Foundation

public enum DataError: Error {
    case duplicateFailure
    case nonExistent
    case incomplete
    case unauthorized
    case noInternet
    case timeout
    case parseFailure(Error?)
    case databaseFailure(Error?)
    case cacheFailure(Error?)
    case serverFailure(Error?)
    case requestFailure(Error?)
    case unknownReason(Error?)
}

public extension DataError {
    
    init(from error: NetworkAPI.Error?) {
        // Handle no internet
        if let internalError = error?.internalError as? URLError,
            internalError.code  == .notConnectedToInternet {
            self = .noInternet
            return
        }
        
        // Handle timeout
        if let internalError = error?.internalError as? URLError,
            internalError.code  == .timedOut {
            self = .timeout
            return
        }
        
        // Handle by status code
        switch error?.response?.statusCode {
        case 400?:
            self = .requestFailure(error)
        case 401?, 403?:
            self = .unauthorized
        default:
            self = .serverFailure(error)
        }
    }
}
