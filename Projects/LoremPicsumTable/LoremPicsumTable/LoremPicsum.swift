//
//  LoremPicsum.swift
//  LoremPicsumTable
//
//  Created by Field Employee on 12/9/20.
//

import Foundation

struct LoremPicsum: Decodable {
    let id: String
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case url = "download_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.url = try container.decode(URL.self, forKey: .url)
    }
}
