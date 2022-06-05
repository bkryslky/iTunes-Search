//
//  MockSearchPresenter.swift
//  iTunesSearchTests
//
//  Created by Guest on 5.06.2022.
//

import Foundation
@testable import iTunesSearch

final class MockSearchPresenter: SearchPresentationLogic {

  weak var viewController: SearchDisplayLogic?
  
  func presentViewDidLoad(response: Search.View.Response) {
    SearchValidator.shared.presenter_presentViewDidLoad_called = true
    let viewModel = Search.View.ViewModel()
    self.viewController?.displayViewDidLoad(viewModel: viewModel)
  }
  func presentSearchEntities(response: Search.Entities.Response) {
    SearchValidator.shared.presenter_presentSearchEntities_called = true
    let viewModel = Search.Entities.ViewModel(entities: response.entities)
    self.viewController?.displaySearchEntities(viewModel: viewModel)
  }
  func presentError(response: Search.Error.Response) {
    SearchValidator.shared.presenter_presentError_called = true
    let viewModel = Search.Error.ViewModel(errorCode: response.errorCode, message: response.message)
    self.viewController?.displayError(viewModel: viewModel)
  }
}
