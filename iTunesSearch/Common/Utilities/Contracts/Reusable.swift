//
//  Reusable.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import Foundation

protocol Reusable {
  static var identifier: String {get}
}

extension Reusable {
  static var identifier: String {
    return String(describing: self)
  }
}
