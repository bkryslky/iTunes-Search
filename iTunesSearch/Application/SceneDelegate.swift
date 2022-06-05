//
//  SceneDelegate.swift
//  iTunesSearch
//
//  Created by Guest on 3.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)
    AppDependencies.shared.configureMainInterface(in: window)
    self.window = window
    self.window?.makeKeyAndVisible()
  }
}
