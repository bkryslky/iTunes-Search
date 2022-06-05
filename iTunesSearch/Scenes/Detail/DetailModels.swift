//
//  DetailModels.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import UIKit

enum Detail {
  // MARK: Use cases
  enum View {
    struct Request {

    }
    struct Response {
      var searchEntity: SearchEntity
    }
    struct ViewModel {
      var searchEntity: SearchEntity
    }
  }
  enum Error {
    struct Request {
    }
    struct Response {
      let errorCode: Int
      let message: String
    }
    struct ViewModel {
      let errorCode: Int
      let message: String
    }
  }
}
