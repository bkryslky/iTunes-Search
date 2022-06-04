//
//  Requester.swift
//  iTunesSearch
//
//  Created by Guest on 3.06.2022.
//

import Foundation

protocol Requester {
  func createRequest<T: RequestableProtocol, Q: Decodable>(requestable: T,
                                    completion: @escaping(Result<Q,APIError>) -> Void)
}
