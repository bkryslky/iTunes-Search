//
//  RequestableProtocol.swift
//  iTunesSearch
//
//  Created by Guest on 3.06.2022.
//

import Foundation

protocol RequestableProtocol {
  func asFileDataRequest() throws -> Data?
  func asURLRequest() throws -> URLRequest?
}
