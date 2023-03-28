//
//  Bundle-decodable.swift
//  Project19_SnowSeeker
//
//  Created by admin on 18/03/2023.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file)")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load data from \(file)")
        }
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode data from file \(file)")
        }
        return decodedData
    }
}
