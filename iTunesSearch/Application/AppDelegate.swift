//
//  AppDelegate.swift
//  iTunesSearch
//
//  Created by Guest on 3.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  func application(_ application: UIApplication, didFinishLaunchingWithOptions
                   launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)
    AppDependencies.shared.configureMainInterface(in: window)
    self.window = window
    self.window?.makeKeyAndVisible()
    return true
  }
}
