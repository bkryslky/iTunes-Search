//
//  SearchRequestable.swift
//  iTunesSearch
//
//  Created by Guest on 3.06.2022.
//

import Foundation
import Alamofire

enum SearchRequestable: Requestable {
    case search(Parameters)
}

extension SearchRequestable {
  var method: HTTPMethod {
    switch self {
    case .search: return .get
    }
  }
  
  var path: String {
    switch self {
    case .search: return "/search"
    }
  }
  
  var extraParams: [String : Any]?  {
    nil
  }
  func asFileDataRequest() throws -> Data? {
    nil
  }
  
  func asURLRequest() throws -> URLRequest? {
    guard let url = urlComponents.url else { return nil }
    var request = URLRequest(url: url)
    for (key, value) in headers {
      request.setValue(key, forHTTPHeaderField: value)
    }
    switch self {
    case let .search(parameters):
      return try URLEncoding.default.encode(request, with: parameters)
    }
  }
}
