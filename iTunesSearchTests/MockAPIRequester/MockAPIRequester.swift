//
//  MockAPIRequester.swift
//  iTunesSearchTests
//
//  Created by Guest on 5.06.2022.
//

import Foundation
@testable import iTunesSearch

final class MockAPIRequester: Requester {
  func createRequest<T, Q>(requestable: T, completion: @escaping (Result<Q, APIError>) -> Void) where T : RequestableProtocol, Q : Decodable {
    do {
      let data = try requestable.asFileDataRequest()
      guard let data = data else {
        completion(.failure(.generalResponseError))
        return
      }
      let response = try JSONDecoder().decode(Q.self, from: data)
      completion(.success(response))
    } catch {
      completion(.failure(.generalResponseError))
    }
  }  
}
