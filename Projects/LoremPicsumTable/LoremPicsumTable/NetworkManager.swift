//
//  NetworkManager.swift
//  LoremPicsumTable
//
//  Created by Field Employee on 12/9/20.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init(){}
    
    func getImageData(from url: URL, completion: @escaping (Data?, Error?) -> Void){
            URLSession.shared.dataTask(with: url){
                (data, response, error) in
                guard let data = data else{ return }
                completion(data, error)
            }.resume()
    }
    
    func getDecodedObject <T: Decodable> (from urlString: String, completion: @escaping (T?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { completion(nil, NetworkError.invalidURL)
            return
        }
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            guard let data = data else { completion(nil, error)
            return }
            guard let loremPicsum = try? JSONDecoder().decode(T.self, from: data) else { return }
            completion(loremPicsum, nil)
        }.resume()
    }
}
