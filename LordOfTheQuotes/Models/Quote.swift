//
//  Quote.swift
//  LordOfTheQuotes
//
//  Created by Matteo Orru on 30/04/25.
//

import Foundation


struct Quote: Codable, Identifiable {
    let id: String
    let dialog: String
    let movie: String
    let character: String
}
