//
//  IndicatorView.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import Foundation
import UIKit

final public class IndicatorView {
  // MARK: Outlets
  public static let shared = IndicatorView()
  private var blurImg = UIImageView()
  private var indicator = UIActivityIndicatorView()
  private let keyWindow = UIApplication
    .shared
    .connectedScenes
    .compactMap { $0 as? UIWindowScene }
    .flatMap { $0.windows }
    .first { $0.isKeyWindow }
  // MARK: Object Lifecycle
  private init() {
    blurImg.frame = UIScreen.main.bounds
    blurImg.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    blurImg.isUserInteractionEnabled = true
    blurImg.alpha = 0.5
    indicator.style = UIActivityIndicatorView.Style.medium
    indicator.center = blurImg.center
    indicator.startAnimating()
    indicator.color = .white
  }
  // MARK: Methods
  func show() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.keyWindow?.addSubview(self.blurImg)
      self.keyWindow?.addSubview(self.indicator)
    }
  }
  func hide() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.blurImg.removeFromSuperview()
      self.indicator.removeFromSuperview()
    }
  }
}
