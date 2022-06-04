//
//  APIError.swift
//  iTunesSearch
//
//  Created by Guest on 3.06.2022.
//

import Foundation

enum APIError: Error {
  case unauthorizedAccessError
  case notFoundError
  case serviceError
  case generalResponseError
  static func findCase(rawValue: Int) -> Self {
    switch rawValue {
    case  401:
      return APIError.unauthorizedAccessError
    case 404:
      return APIError.notFoundError
    case 502 :
      return APIError.serviceError
    default :
      return APIError.generalResponseError
    }
  }
}
