//
//  Films.swift
//  StarWarsAPITable
//
//  Created by Field Employee on 12/20/20.
//

import Foundation

struct Films: Decodable {
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case title
    }
}
