//
//  CharactersViewModel.swift
//  LordOfTheQuotes
//
//  Created by Matteo Orru on 30/04/25.
//

import Foundation
import Combine


class CharactersViewModel {
    private let apiService: APIService
    private let selectedMovie: Movie
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var characters: [Character] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: APIError?
    
    
    init(apiService: APIService, selectedMovie: Movie) {
        self.apiService = apiService
        self.selectedMovie = selectedMovie
    }
    
    
    
    func loadCharacters() {
        isLoading = true
        error = nil
        
        apiService.getCharactersForMovie(movieId: selectedMovie.id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] (completion: Subscribers.Completion<APIError>) in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.error = error
                }
            }, receiveValue: { [weak self] (response: CharacterResponse) in
                self?.characters = response.docs
            })
            .store(in: &cancellables)
    }
    
    
    
    var movieTitle: String {
        return selectedMovie.name
    }
    
    var backgroundImageName: String {
        return selectedMovie.backgroundImageName
    }
    
    
    
    
    
}
