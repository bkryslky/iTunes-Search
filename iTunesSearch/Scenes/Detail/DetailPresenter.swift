//
//  DetailPresenter.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import UIKit

protocol DetailPresentationLogic {
  func presentViewDidLoad(response: Detail.View.Response)
  func presentError(response: Detail.Error.Response)
}

class DetailPresenter: DetailPresentationLogic {
  weak var viewController: DetailDisplayLogic?
  func presentViewDidLoad(response: Detail.View.Response) {
    let viewModel = Detail.View.ViewModel(searchEntity: response.searchEntity)
    viewController?.displayViewDidLoad(viewModel: viewModel)
  }
  func presentError(response: Detail.Error.Response) {
    let viewModel = Detail.Error.ViewModel(errorCode: response.errorCode, message: response.message)
    self.viewController?.displayError(viewModel: viewModel)
  }
}
