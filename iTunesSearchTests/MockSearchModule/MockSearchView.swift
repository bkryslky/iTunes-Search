//
//  MockSearchView.swift
//  iTunesSearchTests
//
//  Created by Guest on 5.06.2022.
//

import Foundation
@testable import iTunesSearch

final class MockSearchViewController: SearchDisplayLogic {
  
  var interactor: SearchBusinessLogic?
  var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
  func displayViewDidLoad(viewModel: Search.View.ViewModel) {
    SearchValidator.shared.view_displayViewDidLoad_called = true
  }
  func displaySearchEntities(viewModel: Search.Entities.ViewModel) {
    SearchValidator.shared.view_search_entities = viewModel.entities
    SearchValidator.shared.view_displaySearchEntities_called = true
  }
  func displayError(viewModel: Search.Error.ViewModel) {
    SearchValidator.shared.view_displayError_called = true
  }
}
