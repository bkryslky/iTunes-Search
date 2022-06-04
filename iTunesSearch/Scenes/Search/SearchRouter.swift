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
    case .toDetail(let entity):
      let destination = DetailViewController.loadFromNib()
      var destinationDS = destination.router?.dataStore
      destinationDS?.searchEntity = entity
      self.viewController?.present(destination, animated: true)
      break
    }
  }

}
