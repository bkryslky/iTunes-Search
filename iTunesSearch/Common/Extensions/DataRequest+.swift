//
//  DataRequest+.swift
//  iTunesSearch
//
//  Created by Guest on 3.06.2022.
//

import Foundation
import Alamofire

extension DataRequest {
  @discardableResult
  public func seralize<T: Decodable>(completionHandler: @escaping (AFDataResponse<T>) -> Void) -> Self {
    return self.responseDecodable(completionHandler: completionHandler)
  }
  func seralize<T: Decodable>(completionHandler: @escaping(Result<T, APIError>) -> Void) {
    _ = self.validate().seralize { (data: AFDataResponse<T>) in
      switch data.result {
      case.success(let payload):
        completionHandler(.success(payload))
      case .failure(let error):
        completionHandler(.failure(APIError.findCase(rawValue: error.responseCode ?? 400)))
      }
    }
  }
  func validate() -> Self {
    return self.validate { _, response, data -> Request.ValidationResult in
      guard (400...599) ~= response.statusCode else { return .success(()) }
      guard data != nil else { return .failure(APIError.generalResponseError) }
      return .failure(APIError.findCase(rawValue: response.statusCode))
    }
  }
}
