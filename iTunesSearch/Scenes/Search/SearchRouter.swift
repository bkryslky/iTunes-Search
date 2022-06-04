//
//  SearchRouter.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import UIKit
enum SearchRoutingLogicOption {
  case toDetail(entity: SearchEntity)
}
protocol SearchRoutingLogic {
  func navigate(_ option: SearchRoutingLogicOption)
}

protocol SearchDataPassing {
  var dataStore: SearchDataStore? { get }
}

class SearchRouter: NSObject, SearchRoutingLogic, SearchDataPassing {

  
  weak var viewController: SearchViewController?
  var dataStore: SearchDataStore?
  func navigate(_ option: SearchRoutingLogicOption) {
    switch option {
    case .toDetail(_):
      // MARK: ToDo
      ///Update here after creating Detail Module!
      break
    }
  }

}
