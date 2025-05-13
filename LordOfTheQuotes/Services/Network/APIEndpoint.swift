//
//  APIEndpoint.swift
//  LordOfTheQuotes
//
//  Created by Matteo Orru on 30/04/25.
//

import Foundation


public enum APIEndpoint {
    case movies
    case movie(id: String)
    case charactersForMovie(movieId: String)
    case character(id: String)
    case quotesForCharacter(characterId: String)
    case quotesForMovie(movieId: String)
    
    public var path: String {
        switch self {
        case .movies:
            return "/movie"
        case .movie(let id):
            return "/movie/\(id)"
        case .charactersForMovie:
            return "/character"
        case .character(let id):
            return "/character/\(id)"
        case .quotesForCharacter(let characterId):
            return "/character/\(characterId)/quote"
        case .quotesForMovie(let movieId):
            return "/movie/\(movieId)/quote"
        }
    }
    
    public var queryItems: [URLQueryItem] {
        switch self {
        case .charactersForMovie(let movieId):
            return [URLQueryItem(name: "movie", value: movieId)]
        default:
            return []
        }
    }
}
