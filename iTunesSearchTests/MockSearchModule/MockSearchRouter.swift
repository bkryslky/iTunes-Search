//
//  MockSearchRouter.swift
//  iTunesSearchTests
//
//  Created by Guest on 5.06.2022.
//

import Foundation
@testable import iTunesSearch

final class MockSearchRouter: NSObject, SearchRoutingLogic, SearchDataPassing {
  weak var viewController: SearchDisplayLogic?
  var dataStore: SearchDataStore?
  func navigate(_ option: SearchRoutingLogicOption) {
    switch option {
    case .toDetail(_):
      SearchValidator.shared.router_toDetail_called = true
    }
  }
}
