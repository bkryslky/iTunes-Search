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
}
