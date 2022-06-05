//
//  APIRequester.swift
//  iTunesSearch
//
//  Created by Guest on 3.06.2022.
//

import Foundation

final class APIRequester: Requester {
  static let shared: APIRequester = APIRequester()
  func createRequest<T, Q>(requestable: T,
                           completion: @escaping (Result<Q, APIError>) -> Void)
  where Q : Decodable, T : RequestableProtocol {
    do {
      let request = try requestable.asURLRequest()
      request?.perform(completionHandler: completion)
    } catch {
      completion(.failure(.generalResponseError))
    }
  }
}
