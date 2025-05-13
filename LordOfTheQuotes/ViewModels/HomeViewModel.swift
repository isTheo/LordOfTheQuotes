//
//  HomeViewModel.swift
//  LordOfTheQuotes
//
//  Created by Matteo Orru on 30/04/25.
//

import Foundation
import Combine


class HomeViewModel {
    private let apiService: APIService
    private var cancellables = Set<AnyCancellable>()
    

    @Published private(set) var movies: [Movie] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: APIError?
    
    
    init(apiService: APIService) {
        self.apiService = apiService
        
    }
    
    
    func loadMovies() {
        isLoading = true
        error = nil
        
        apiService.getMovies()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] (completion: Subscribers.Completion<APIError>) in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.error = error
                }
            }, receiveValue: { [weak self] (response: MovieResponse) in
                // Filtra solo i film della trilogia del Signore degli Anelli
                let lotrMovies = response.docs.filter { movie in
                    ["5cd95395de30eff6ebccde5b", "5cd95395de30eff6ebccde5c", "5cd95395de30eff6ebccde5d"].contains(movie.id)
                }
                self?.movies = lotrMovies
            })
            .store(in: &cancellables)
    }
    
    
}
