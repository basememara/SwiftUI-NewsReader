//
//  File.swift
//  
//
//  Created by Basem Emara on 2019-11-19.
//

public extension Result {
    
    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    var error: Failure? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}
