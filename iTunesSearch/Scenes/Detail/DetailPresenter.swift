//
//  DetailPresenter.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import UIKit

protocol DetailPresentationLogic {
  func presentViewDidLoad(response: Detail.View.Response)
}

class DetailPresenter: DetailPresentationLogic {
  weak var viewController: DetailDisplayLogic?
  func presentViewDidLoad(response: Detail.View.Response) {
    let viewModel = Detail.View.ViewModel(searchEntity: response.searchEntity)
    viewController?.displayViewDidLoad(viewModel: viewModel)
  }
}
