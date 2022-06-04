//
//  WrapperType.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import Foundation

enum WrapperType: String, Codable {
  case movies = "movie", music = "music", apps = "software", books = "ebook"
  
  static func findCase(value: Int) -> Self {
    switch value{
    case 0:
      return WrapperType.movies
    case 1:
      return WrapperType.music
    case 2:
      return WrapperType.apps
    case 3:
      return WrapperType.books
    default:
      return WrapperType.movies
    }
  }
}
