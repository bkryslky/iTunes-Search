//
//  ViewModelType.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import Foundation

protocol ViewModelType {
    associatedtype T
    func configure(model: T)
}
