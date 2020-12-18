//
//  HomeWorld.swift
//  StarWarsAPITable
//
//  Created by Field Employee on 12/18/20.
//

import Foundation

struct HomeWorld: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
