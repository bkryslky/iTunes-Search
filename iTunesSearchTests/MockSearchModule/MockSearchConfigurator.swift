//
//  MockSearchConfigurator.swift
//  iTunesSearchTests
//
//  Created by Guest on 5.06.2022.
//

import Foundation
@testable import iTunesSearch

final class MockSearchConfigurator {

  private var viewController: SearchDisplayLogic?
  private var interactor: (SearchBusinessLogic & SearchDataStore)?
  private var presenter: SearchPresentationLogic?
  private var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
  
  init(viewController: inout MockSearchViewController, interactor: inout MockSearchInteractor, presenter: inout MockSearchPresenter, router: inout MockSearchRouter){
    self.viewController = viewController
    self.presenter = presenter
    self.interactor = interactor
    self.router = router
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }

}

