//
//  DetailRouter.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import UIKit

protocol DetailRoutingLogic {
}

protocol DetailDataPassing {
  var dataStore: DetailDataStore? { get }
}

class DetailRouter: NSObject, DetailRoutingLogic, DetailDataPassing {
  weak var viewController: DetailViewController?
  var dataStore: DetailDataStore?

}
