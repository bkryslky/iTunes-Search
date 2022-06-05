//
//  MockSearchRequestable.swift
//  iTunesSearchTests
//
//  Created by Guest on 5.06.2022.
//

import Foundation
import Alamofire

@testable import iTunesSearch
enum MockSearchRequestable: MockRequestable {
    case search(Parameters)

}

extension MockSearchRequestable {
  
  var filePath: String {
    switch self {
    case .search:
      return !SearchValidator.shared.showError ? "MockSearchData" : "Wrong File Path"
    }
  }
  
  func asFileDataRequest() throws -> Data? {
    switch self {
    case .search:
      guard let filePath = Bundle.main.url(forResource: filePath, withExtension: "json") else {
        throw APIError.generalResponseError
      }
      return try  Data(contentsOf: filePath)
    }
  }
  
  func asURLRequest() throws -> URLRequest? {
    nil
  }
}
