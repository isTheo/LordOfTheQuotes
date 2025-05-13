//
//  APIError.swift
//  LordOfTheQuotes
//
//  Created by Matteo Orru on 30/04/25.
//

import Foundation


public enum APIError: Error {
    case invalidURL
    case invalidResponse
    case networkError(Error)
    case decodingError(Error)
    case serverError(statusCode: Int)
    case unauthorized
    case unknown
    
    public var errorMessage: String {
        switch self {
        case .invalidURL:
            return "I don’t think that’s the right path, Mr. Frodo. That URL leads nowhere good."
        case .invalidResponse:
            return "Server did not return a valid response"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Error in decoding JSON: \(error.localizedDescription)"
        case .serverError(let statusCode):
            return "Server error with status code: \(statusCode)"
        case .unauthorized:
            return "We’ve no key, no password… I don’t think they’ll let us in, Mr. Frodo."
        case .unknown:
            return "I don’t know what it is... but I’ve got a bad feeling in my gut about it."
        }
    }
}
