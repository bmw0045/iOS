//
//  Pokemon.swift
//  PokedexProject
//
//  Created by Field Employee on 12/6/20.
//

import Foundation

struct Pokemon {
    //let abilities: [Ability]
    let name: String
    let baseExp: Int
    let weight: Int
    
    init?(json: [String: Any]){
        guard let name = json["name"] as? String,
        let baseExp = json["base_experience"] as? Int,
        let weight = json["weight"] as? Int else {return nil}
        
        self.name = name
        self.baseExp = baseExp
        self.weight = weight
    }
}

struct CodablePokemon: Decodable {
    let name: String
   // let speciesName: String
    let baseExp: Int
    let weight: Int
    let abilities: [Ability]
   // let speciesURL: URL
   // let species: Species
    
    enum CodingKeys: String, CodingKey {
        case name
        case baseExp = "base_experience"
        case weight
        case abilities
       // case species
    }
    
    enum SpeciesCodingKeys: String, CodingKey {
        case name
        case speciesURL = "URL"
    }
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//       // let speciesContainer = try container.nestedContainer(keyedBy: SpeciesCodingKeys.self, forKey: .species)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.baseExp = try container.decode(Int.self, forKey: .baseExp)
//        self.weight = try container.decode(Int.self, forKey: .weight)
////        self.speciesName = try speciesContainer.decode(String.self, forKey: .name)
//        self.speciesURL = try speciesContainer.decode(URL.self, forKey: .speciesURL)
//        self.abilities = try container.decode([Ability].self, forKey: .abilities)
//    }
}

struct Species: Decodable {
    let name: String
    let URL: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case URL
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.URL = try container.decode(String.self, forKey: .URL)
    }
}
struct Ability: Decodable {
    let isHidden: Bool
    //let ability: AbilityContainer
    let slot: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case ability
        case slot
    }
    
    enum AbilityCodingKeys: String, CodingKey {
        case name
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let abilityContainer = try container.nestedContainer(keyedBy: AbilityCodingKeys.self, forKey: .ability)
        self.name = try abilityContainer.decode(String.self, forKey: .name)
        self.isHidden = try container.decode(Bool.self, forKey: .isHidden)
        self.slot = try container.decode(Int.self, forKey: .slot)
    }
}
//struct AbilityContainer: Decodable {
//    let name: String
//    let URL: String
//}
