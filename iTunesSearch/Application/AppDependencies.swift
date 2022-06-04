//
//  AppDependencies.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import UIKit

final class AppDependencies {
  static let shared = AppDependencies()
  private init() { }
  func configureMainInterface(in window: UIWindow) {
    let viewController = SearchViewController.loadFromNib()
    let navVC = UINavigationController(rootViewController:viewController)
    window.rootViewController = navVC
  }
}
