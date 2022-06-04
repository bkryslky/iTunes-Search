//
//  SearchInteractor.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import UIKit

protocol SearchBusinessLogic {
  func viewDidLoad(request: Search.View.Request)
  func didSearchEntities(request: Search.Entities.Request)
  func didLoadMoreEntities()
}

protocol SearchDataStore {
}

class SearchInteractor: SearchBusinessLogic, SearchDataStore {

  var presenter: SearchPresentationLogic?
  var worker: SearchWorker = SearchWorker.shared
  private var wrapperType: WrapperType = .movies
  private var page: Int = 1
  private var query: String = ""
  private let limit: Int = 20
  func viewDidLoad(request: Search.View.Request) {
    self.wrapperType = request.wrapperType
    self.presenter?.presentViewDidLoad(response: Search.View.Response())
  }
  
  func didSearchEntities(request: Search.Entities.Request) {
    self.page = 1
    self.wrapperType = request.wrapperType
    self.query = request.query
    self.getEntities()
  }
  
  func didLoadMoreEntities() {
    self.page += 1
    self.getEntities()
  }

}
extension SearchInteractor {
  private func getEntities() {
    IndicatorView.shared.show()
    let parameters: [String : Any] = ["term": self.query,
                                      "entity": self.wrapperType.rawValue,
                                      "limit": self.limit * self.page
    ]
    
    worker.searchItems(parameters: parameters) { [weak self] result in
      IndicatorView.shared.hide()
      switch result {
      case .failure(let error):
        print(error)
      case .success(let baseResponse):
        guard let entities = baseResponse.data else { return }
        self?.presenter?.presentSearchEntities(response: Search.Entities.Response(entities: entities))
      }
    }
  }
}
