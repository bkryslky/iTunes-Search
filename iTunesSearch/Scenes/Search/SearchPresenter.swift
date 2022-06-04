//
//  SearchPresenter.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import UIKit

protocol SearchPresentationLogic {
  func presentViewDidLoad(response: Search.View.Response)
  func presentSearchEntities(response: Search.Entities.Response)
}

class SearchPresenter: SearchPresentationLogic {
 
  weak var viewController: SearchDisplayLogic?
  
  func presentViewDidLoad(response: Search.View.Response) {
    let viewModel = Search.View.ViewModel()
    self.viewController?.displayViewDidLoad(viewModel: viewModel)
  }
  func presentSearchEntities(response: Search.Entities.Response) {
    let viewModel = Search.Entities.ViewModel(entities: response.entities)
    self.viewController?.displaySearchEntities(viewModel: viewModel)
  }
}
