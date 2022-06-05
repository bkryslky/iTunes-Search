//
//  MockRequestable.swift
//  iTunesSearchTests
//
//  Created by Guest on 5.06.2022.
//

import Foundation
@testable import iTunesSearch

protocol MockRequestable: RequestableProtocol {
  var filePath: String { get }
}
