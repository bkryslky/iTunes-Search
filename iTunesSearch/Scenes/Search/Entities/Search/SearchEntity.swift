//
//  SearchEntity.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import Foundation

struct SearchEntity: Codable {
    let wrapperType: String?
    let kind: String?
    let trackId: Int?
    let artworkUrl100: String?
    let releaseDate: String?
    let collectionPrice: Double?
    let collectionName: String?
    let trackName: String?
}
