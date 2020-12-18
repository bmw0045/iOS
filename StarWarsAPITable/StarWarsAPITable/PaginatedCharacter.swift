//
//  Characters.swift
//  StarWarsAPITable
//
//  Created by Field Employee on 12/18/20.
//

import Foundation

struct PaginatedCharacter: Decodable {
    let next: String
    let results: [SWCharacterResult]
    
    enum CodingKeys: String, CodingKey {
        case next
        case results
    }
}

struct SWCharacterResult: Decodable {
    let name: String
    let hair: String
    let eyes: String
    let planet: String
    
    enum ResultCodingKeys: String, CodingKey {
        case name
        case hair = "hair_color"
        case eyes = "eye_color"
        case planet = "homeworld"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResultCodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.hair = try container.decode(String.self, forKey: .hair)
        self.eyes = try container.decode(String.self, forKey: .eyes)
        self.planet = try container.decode(String.self, forKey: .planet)
    }
}
