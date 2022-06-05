//
//  SearchModels.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import UIKit

enum Search {
  // MARK: Use cases  
  enum View {
      struct Request {
        let wrapperType: WrapperType
      }
    struct Response {

    }
    struct ViewModel {
    }
  }
  enum Entities {
    struct Request {
      let wrapperType: WrapperType
      let query: String
    }
    struct Response {
      let entities : [SearchEntity]
    }
    struct ViewModel {
      let entities : [SearchEntity]
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
