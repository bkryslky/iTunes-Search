//
//  String+.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import UIKit

extension String {
  func appDateFormatted() -> (String, Int, Int, Int) {
    let formatter = DateFormatter()
    let date = formatter.date(from: self)
    formatter.dateFormat = "dd.MM.yyyy"
    let newDateString = formatter.string(from: date ?? Date())
    let components = formatter.calendar.dateComponents(.init(), from: date ?? Date())
    let year = components.year ?? 1976
    let month = components.month ?? 1
    let day = components.day ?? 1
    
    return (newDateString, day, month, year)
  }
  
  func toURL() -> URL? {
    return URL(string: self)
  }
}
