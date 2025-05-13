//
//  MovieResponse.swift
//  LordOfTheQuotes
//
//  Created by Matteo Orru on 30/04/25.
//

import Foundation


struct MovieResponse: Codable {
    let docs: [Movie]
    let total: Int
    let limit: Int
    let offset: Int
    let page: Int
    let pages: Int
}
