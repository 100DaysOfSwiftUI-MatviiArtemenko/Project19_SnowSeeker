//
//  Resort.swift
//  Project19_SnowSeeker
//
//  Created by admin on 18/03/2023.
//

import Foundation

struct Resort: Identifiable, Codable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]

    var facilityType: [Facitity] {
        facilities.map(Facitity.init)
    }

    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example: Resort = allResorts[0]
}
