//
//  DetailInteractor.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import UIKit

protocol DetailBusinessLogic {
  func viewDidLoad()
}

protocol DetailDataStore {
  var searchEntity: SearchEntity? { get set }
}

class DetailInteractor: DetailBusinessLogic, DetailDataStore {
  var presenter: DetailPresentationLogic?
  var worker: DetailWorker = DetailWorker()
  var searchEntity: SearchEntity?
  
  func viewDidLoad() {
    guard let searchEntity = searchEntity else {
      return
    }
    let response = Detail.View.Response(searchEntity: searchEntity)
    self.presenter?.presentViewDidLoad(response: response)
  }

}
