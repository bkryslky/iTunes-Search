//
//  BaseResponse.swift
//  iTunesSearch
//
//  Created by Guest on 3.06.2022.
//

import Foundation

struct BaseResponse<T>: Codable where T: Codable {
    var data: T?
    enum CodingKeys: String, CodingKey {
      case data = "results"
    }
}
