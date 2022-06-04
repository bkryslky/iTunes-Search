//
//  URLRequest+.swift
//  iTunesSearch
//
//  Created by Guest on 3.06.2022.
//

import Foundation
import Alamofire

extension URLRequest {
    func perform<T>(completionHandler: @escaping(Result<T, APIError>) -> Void) where T: Decodable {
    return AF.request(self).seralize { data in
        completionHandler(data)
    }
  }
}
