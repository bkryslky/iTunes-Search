//
//  SearchValidator.swift
//  iTunesSearchTests
//
//  Created by Guest on 5.06.2022.
//

import Foundation

@testable import iTunesSearch
class SearchValidator {
  static let shared = SearchValidator()
  var showError: Bool = false
  // MARK: View
  var view_displayViewDidLoad_called: Bool = false
  var view_displaySearchEntities_called: Bool = false
  var view_displayError_called: Bool = false
  var view_search_entities: [SearchEntity] = []
  var view_wrapper_type: WrapperType = .movies
  
  // MARK: Interactor
  var interactor_viewDidLoad_called: Bool = false
  var interactor_didSearchEntities_called: Bool = false
  var interactor_didLoadMoreEntities_called: Bool = false
  
  // MARK: Presenter
  var presenter_presentViewDidLoad_called: Bool = false
  var presenter_presentSearchEntities_called: Bool = false
  var presenter_presentError_called: Bool = false
  
  // MARK: Router
  var router_toDetail_called: Bool = false
  
  // MARK: Worker
  var worker_search_called: Bool = false
  
  // MARK: Indicator
  var indicator_show_called: Bool = false
  var indicator_hide_called: Bool = false
  
}
