//
//  MockSearchWorker.swift
//  iTunesSearchTests
//
//  Created by Guest on 5.06.2022.
//

import Foundation
import Alamofire
@testable import iTunesSearch

final class MockSearchWorker: SearchWorkerProtocol {
  
  var requester: Requester = MockAPIRequester()
  
  func searchItems(parameters: [String : Any], completionHandler: @escaping (Result<BaseResponse<[SearchEntity]>, APIError>) -> Void) {
    SearchValidator.shared.worker_search_called = true
    requester.createRequest(requestable: MockSearchRequestable.search(parameters), completion: completionHandler)
  }
}
