//
//  APIService.swift
//  LordOfTheQuotes
//
//  Created by Matteo Orru on 30/04/25.
//

import Foundation
import Combine



class APIService {
    private let baseURL = "https://the-one-api.dev/v2"
    private let apiToken = APIConfig.token
    
    
    func request <T: Decodable> (endpoint: APIEndpoint) -> AnyPublisher <T, APIError> {
        var components = URLComponents(string: baseURL + endpoint.path)
        components?.queryItems = endpoint.queryItems
        
        guard let url = components?.url else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                
                switch httpResponse.statusCode {
                case 200...299:
                    return data
                case 401:
                    throw APIError.unauthorized
                default:
                    throw APIError.serverError(statusCode: httpResponse.statusCode)
                }
            }
        
            .mapError { error in
                if let apiError = error as? APIError {
                    return apiError
                }
                
                return APIError.networkError(error)
            }
        
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    return APIError.decodingError(decodingError)
                }
                
                return error as? APIError ?? APIError.unknown
            }
        
            .eraseToAnyPublisher()
        
    }//func request
    
    
    func getMovies() -> AnyPublisher <MovieResponse, APIError> {
        return request(endpoint: .movies)
    }
    
    func getCharactersForMovie(movieId: String) -> AnyPublisher <CharacterResponse, APIError> {
        return request(endpoint: .charactersForMovie(movieId: movieId))
    }
    
//    func getQuotesForCharacter(characterId: String, movieId: String) -> AnyPublisher <QuoteResponse, APIError> {
//        let endpoint = APIEndpoint.quotesForCharacter(characterId: characterId)
//        return request(endpoint: endpoint)
//            .map { (response: QuoteResponse) -> QuoteResponse in
//                //filter quotes by specific movie
//                let filteredQuotes = response.docs.filter { $0.movieId == movieId }
//                return QuoteResponse (
//                    docs: filteredQuotes,
//                    total: filteredQuotes.count,
//                    limit: response.limit,
//                    offset: response.offset,
//                    page: response.page,
//                    pages: response.pages
//                )
//            }
//        
//            .eraseToAnyPublisher()
//    }
                               
}//class
