//
//  SearchWorker.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import UIKit

protocol SearchWorkerProtocol {
  func searchItems(parameters: [String: Any], completionHandler: @escaping  (Result<BaseResponse<[SearchEntity]>, APIError>) -> Void)
   
}
class SearchWorker: SearchWorkerProtocol {
  static let shared = SearchWorker()
  var requester: Requester
  init(requester: Requester = APIRequester()){
    self.requester = requester
  }
  func searchItems(parameters: [String : Any], completionHandler: @escaping (Result<BaseResponse<[SearchEntity]>, APIError>) -> Void) {
    requester.createRequest(requestable: SearchRequestable.search(parameters), completion: completionHandler)
  }
  

}
