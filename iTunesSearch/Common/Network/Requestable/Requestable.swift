//
//  Requestable.swift
//  iTunesSearch
//
//  Created by Guest on 3.06.2022.
//

import Foundation
import Alamofire

protocol Requestable: RequestableProtocol {
  var path: String { get }
  var headers: [String: String] { get }
  var method: HTTPMethod { get }
  var extraParams: [String : Any]? { get }
}

extension Requestable {
  var baseURL: String {
    return iTunesConstants.API.BaseURL
  }
  var headers: [String : String] {
    return [:]
  }
  var additionalParams: [String : Any] {
    return [:]
  }
  var urlComponents: URLComponents {
    guard var components = URLComponents(string: baseURL) else {
      fatalError("URLComponents cannot be created")
    }
    components.path =  path
    var queryItems: [URLQueryItem] = []
    let params = additionalParams.map({ (key, value) -> URLQueryItem in
      return URLQueryItem(name: "\(key)", value: "\(value)") })
    let extraParameters = extraParams?.map({ (key, value) -> URLQueryItem in
      return URLQueryItem(name: "\(key)", value: "\(value)") })
    queryItems.append(contentsOf: params)
    queryItems.append(contentsOf: extraParameters ?? [])
    components.queryItems = queryItems
    return components
  }
}
