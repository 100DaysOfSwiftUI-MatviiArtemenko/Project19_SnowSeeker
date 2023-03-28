//
//  Favorites.swift
//  Project19_SnowSeeker
//
//  Created by admin on 18/03/2023.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites"

    init() {
        // MARK: Challenge #2

        if let data = UserDefaults.standard.data(forKey: saveKey) {
            let decoder = JSONDecoder()
            do {
                resorts = try decoder.decode(Set<String>.self, from: data)
            } catch {
                fatalError("Failed decoding data \(error.localizedDescription)")
            }
        } else {
            resorts = []
        }
    }

    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

//        MARK: Challenge #2

    func save() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(resorts) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }
}
