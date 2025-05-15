//
//  Movie.swift
//  LordOfTheQuotes
//
//  Created by Matteo Orru on 30/04/25.
//

import Foundation


struct Movie: Codable, Identifiable {
    let id: String
    let name: String
    //I'm not sure if I'm using these
//    let runtimeInMinutes: Int?
//    let budgetInMillions: Double?
//    let boxOfficeRevenueInMillions: Double?
//    let academyAwardNominations: Int?
//    let academyAwardWins: Int?
    
    var backgroundImageName: String {
        switch id {
        case "5cd95395de30eff6ebccde5b": //Fellowship of the Ring
            return "fellowship_background"
        case "5cd95395de30eff6ebccde5c": //Two Towers
            return "two_towers_background"
        case "5cd95395de30eff6ebccde5d": //Return of the King
            return "return_king_background"
        default:
            return "default_background"
        }
    }
}
