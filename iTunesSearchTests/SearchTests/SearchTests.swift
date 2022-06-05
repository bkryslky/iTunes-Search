//
//  SearchTests.swift
//  iTunesSearchTests
//
//  Created by Guest on 5.06.2022.
//

import XCTest
@testable import iTunesSearch

class SearchTests: XCTestCase {

  var mockViewController: MockSearchViewController?
  var mockInteractor: MockSearchInteractor?
  var mockPresenter: MockSearchPresenter?
  var mockWorker: MockSearchWorker?
  var mockRouter: MockSearchRouter?
  var mockConfigurator: MockSearchConfigurator?
  
  override func setUp() {
    super.setUp()
    mockWorker = MockSearchWorker()
    mockViewController = MockSearchViewController()
    mockInteractor = MockSearchInteractor(worker: mockWorker!)
    mockPresenter = MockSearchPresenter()
    mockRouter = MockSearchRouter()
    mockConfigurator = MockSearchConfigurator(viewController: &mockViewController!, interactor: &mockInteractor!, presenter: &mockPresenter!, router: &mockRouter!)
    
    self.mockInteractor?.viewDidLoad(request: Search.View.Request(wrapperType: .movies))
  }
  
  private func validatorSearchDefaults() {
    SearchValidator.shared.presenter_presentSearchEntities_called = false
    SearchValidator.shared.view_displayError_called = false
    SearchValidator.shared.indicator_show_called = false
    SearchValidator.shared.indicator_hide_called = false
    SearchValidator.shared.showError = false
  }
  func test_searchViewDidLoad() {
    XCTAssert(SearchValidator.shared.interactor_viewDidLoad_called, "Mock Search Interactor viewDidLoad method called!")
    DispatchQueue.main.async { [weak self] in
      XCTAssert(SearchValidator.shared.presenter_presentViewDidLoad_called, "Mock Search Presenter presentViewDidLoad method called!")
      XCTAssert(SearchValidator.shared.view_displayViewDidLoad_called, "Mock Search ViewController displayViewDidLoad method called!")
      XCTAssert(self?.mockInteractor?.wrapperType == SearchValidator.shared.view_wrapper_type, "Search wrapper type equality called!")
    }
  }
  func test_searchEntities() {
    self.validatorSearchDefaults()
    let request = Search.Entities.Request(wrapperType: .movies, query: "max")
    self.mockInteractor?.didSearchEntities(request: request)
    XCTAssert(SearchValidator.shared.indicator_show_called, "Indicator View show method called!")
    DispatchQueue.main.async { [weak self] in
      XCTAssert(SearchValidator.shared.presenter_presentSearchEntities_called, "Mock Search Presenter presentSearchEntities method called!")
      XCTAssert(SearchValidator.shared.view_displaySearchEntities_called, "Mock Search ViewController displaySearchEntities method called!")
      XCTAssert(self?.mockInteractor?.searchEntities.first?.trackId == SearchValidator.shared.view_search_entities.first?.trackId, "Search first item id equality called!")
      XCTAssert(SearchValidator.shared.view_search_entities.first?.trackName == "Max (2015)", "Search first item id equality called!")
      XCTAssert(SearchValidator.shared.indicator_hide_called, "Indicator View hide method called!")
    }
  }
  
  func test_searchEntities_ErrorState() {
    self.validatorSearchDefaults()
    SearchValidator.shared.showError = true
    let request = Search.Entities.Request(wrapperType: .movies, query: "max")
    self.mockInteractor?.didSearchEntities(request: request)
    XCTAssert(SearchValidator.shared.interactor_viewDidLoad_called, "Mock Search Interactor viewDidLoad method called!")
    XCTAssert(SearchValidator.shared.indicator_show_called, "Indicator View show method called!")
    DispatchQueue.main.async {
      XCTAssert(SearchValidator.shared.presenter_presentError_called, "Mock Search Presenter presentError method called!")
      XCTAssert(SearchValidator.shared.view_displayError_called, "Mock Search ViewController displayError method called!")
      XCTAssert(SearchValidator.shared.indicator_hide_called, "Indicator View hide method called!")
    }
  }
  
  func test_searchRouting() {
    
    DispatchQueue.main.async { [weak self] in
      if let entity = SearchValidator.shared.view_search_entities.first {
        self?.mockRouter?.navigate(.toDetail(entity: entity))
      }
      XCTAssert(SearchValidator.shared.router_toDetail_called, "Mock Search Router navigate method called for entity detail!")
    }

  }
  
  override func tearDown() {
    super.tearDown()
    mockViewController = nil
    mockInteractor = nil
    mockPresenter = nil
    mockConfigurator = nil
    mockWorker = nil
  }

}

