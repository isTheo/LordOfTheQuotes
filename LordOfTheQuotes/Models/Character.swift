//
//  Character.swift
//  LordOfTheQuotes
//
//  Created by Matteo Orru on 30/04/25.
//

import Foundation


struct Character: Codable, Identifiable {
    let id: String
    let name: String
    let race: String?
    let gender: String?
    let realm: String?
    
    var imageName: String {
        return name.lowercased()
            .replacingOccurrences(of: " ", with: "_")
            .replacingOccurrences(of: "'", with: "")
    }
}
