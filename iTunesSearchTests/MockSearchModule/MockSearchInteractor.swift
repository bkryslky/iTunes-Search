//
//  MockSearchInteractor.swift
//  iTunesSearchTests
//
//  Created by Guest on 5.06.2022.
//

import Foundation
@testable import iTunesSearch

final class MockSearchInteractor: SearchBusinessLogic, SearchDataStore {

  var presenter: SearchPresentationLogic?
  var worker: MockSearchWorker
  private var page: Int = 1
  var searchEntities = [SearchEntity]()
  var wrapperType: WrapperType = .movies
  init(worker: MockSearchWorker = MockSearchWorker()) {
    self.worker = worker
  }
  func viewDidLoad(request: Search.View.Request) {
    self.wrapperType = request.wrapperType
    SearchValidator.shared.view_wrapper_type = request.wrapperType
    SearchValidator.shared.interactor_viewDidLoad_called = true
  }
  func didSearchEntities(request: Search.Entities.Request) {
    SearchValidator.shared.interactor_didSearchEntities_called = true
    self.searchEntities(term: request.query, limit: 20, type: .movies)
  }
  func didLoadMoreEntities() {
    SearchValidator.shared.interactor_didLoadMoreEntities_called = true
  }
  private func searchEntities(term: String, limit: Int, type: WrapperType) {
    SearchValidator.shared.indicator_show_called = true
    let parameters: [String: Any] = ["term": term, "limit": limit*page, "entity": type.rawValue]
    worker.searchItems(parameters: parameters) { [weak self] result in
      switch result {
      case .success(let baseResponse):
        self?.searchEntities = baseResponse.data ?? []
        let response = Search.Entities.Response(entities: baseResponse.data ?? [])
        self?.presenter?.presentSearchEntities(response: response)
      case .failure(let error):
        self?.presenter?.presentError(response: Search.Error.Response(errorCode: error.asAFError?.responseCode ?? 0, message: error.localizedDescription))
      }
      SearchValidator.shared.indicator_hide_called = true
    }
  }

}
