//
//  Pokemon.swift
//  PokedexProject
//
//  Created by Field Employee on 12/6/20.
//

import Foundation

//struct Pokemon {
//    //let abilities: [Ability]
//    let name: String
//    let baseExp: Int
//    let weight: Int
//
//    init?(json: [String: Any]){
//        guard let name = json["name"] as? String,
//        let baseExp = json["base_experience"] as? Int,
//        let weight = json["weight"] as? Int else {return nil}
//
//        self.name = name
//        self.baseExp = baseExp
//        self.weight = weight
//    }
//}

struct CodablePokemon: Decodable {
    let name: String
    let baseExp: Int
    let weight: Int
    let abilities: [Ability]
    let species: Species
    let sprites: Sprites
    let allMoves: [Moves]
    
    enum CodingKeys: String, CodingKey {
        case name
        case baseExp = "base_experience"
        case weight
        case abilities
        case species
        case sprites
        case allMoves = "moves"
    }
}

struct Species: Decodable {
    let name: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}

struct Sprites: Decodable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: URL?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}

struct Moves: Decodable {
    let move: String?
    let url: String?
    let details: [Detail]?
    
    enum CodingKeys: String, CodingKey {
        case move
        case details = "version_group_details"
    }
    enum MoveCodingKeys: String, CodingKey {
       case name
       case url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let moveContainer = try container.nestedContainer(keyedBy: MoveCodingKeys.self, forKey: .move)
        self.move = try moveContainer.decodeIfPresent(String.self, forKey: .name)
        self.url = try moveContainer.decodeIfPresent(String.self, forKey: .url)
        self.details = try container.decodeIfPresent([Detail].self, forKey: .details)
    }
    
    struct Detail: Decodable {
        let levelLearnedAt: Int
        let moveName: String?
        let moveURL: String?
        let versionName: String?
        let versionURL: String?

        enum DetailCodingKeys: String, CodingKey {
            case levelLearnedAt = "level_learned_at"
            case moveLearnMethod = "move_learn_method"
            case versionGroup = "version_group"
        }
        
        enum LearnMethodCodingKeys: String, CodingKey {
            case name
            case url
        }
        
        enum VersionCodingKeys: String, CodingKey {
            case name
            case url
        }
        
        init(from decoder: Decoder) throws {
            let detailContainer = try decoder.container(keyedBy: DetailCodingKeys.self)
            let learnMethodContainer = try detailContainer.nestedContainer(keyedBy: LearnMethodCodingKeys.self, forKey: .moveLearnMethod)
            let versionGroupContainer = try detailContainer.nestedContainer(keyedBy: VersionCodingKeys.self, forKey: .versionGroup)
            self.levelLearnedAt = try detailContainer.decode(Int.self, forKey: .levelLearnedAt)
            self.moveName = try learnMethodContainer.decodeIfPresent(String.self, forKey: .name)
            self.moveURL = try learnMethodContainer.decodeIfPresent(String.self, forKey: .url)
            self.versionName = try versionGroupContainer.decodeIfPresent(String.self, forKey: .name)
            self.versionURL = try versionGroupContainer.decodeIfPresent(String.self, forKey: .url)
        }
    }
}

struct Ability: Decodable {
    let isHidden: Bool
    let slot: Int
    let name: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case ability
        case slot
    }
    
    enum AbilityCodingKeys: String, CodingKey {
        case name
        case url
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let abilityContainer = try container.nestedContainer(keyedBy: AbilityCodingKeys.self, forKey: .ability)
        self.name = try abilityContainer.decode(String.self, forKey: .name)
        self.url = try abilityContainer.decode(String.self, forKey: .url)
        self.isHidden = try container.decode(Bool.self, forKey: .isHidden)
        self.slot = try container.decode(Int.self, forKey: .slot)
    }
}
