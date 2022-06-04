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
      let response = Detail.Error.Response(errorCode: 404, message:"Entity not found!")
      self.presenter?.presentError(response: response)
      return
    }
    let response = Detail.View.Response(searchEntity: searchEntity)
    self.presenter?.presentViewDidLoad(response: response)
  }

}
