//
//  SearchViewController.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import UIKit

protocol SearchDisplayLogic: AnyObject {
  func displayViewDidLoad(viewModel: Search.View.ViewModel)
  func displaySearchEntities(viewModel: Search.Entities.ViewModel)
  func displayError(viewModel: Search.Error.ViewModel)
}

class SearchViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var searchCollectionView: UICollectionView!
  @IBOutlet weak var searchSegmentedControl: UISegmentedControl!
  
  // MARK: Variables
  private var searchEntities: [SearchEntity] = []
  private var isLoadingMore: Bool = false
  var interactor: SearchBusinessLogic?
  var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
  
  struct LocalConstants {
    struct Keys {
      static let title = "Contents"
      static let search = "Search..."
      static let ok = "Okay"
      static let errorTitle = "Something went wrong!"
    }
    struct UIs {
      struct SearchCollectionView {
        static let estimatedItemSize: CGSize = UICollectionViewFlowLayout.automaticSize
        static let space: CGFloat = 8.0
        static let edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        static let threshold: CGFloat = 100.0
      }
    }
  }
  
  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController = self
    let interactor = SearchInteractor()
    let presenter = SearchPresenter()
    let router = SearchRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.prepareViews()
    let request = Search.View.Request(wrapperType: WrapperType.findCase(value: searchSegmentedControl.selectedSegmentIndex))
    self.interactor?.viewDidLoad(request: request)
  }
  
  // MARK: Methods
  private func prepareViews() {
    self.prepareSearchBar()
    self.prepareCollectionView()
  }
  private func prepareSearchBar() {
    self.searchBar.placeholder = LocalConstants.Keys.search
    self.searchBar.delegate = self
    self.searchBar.becomeFirstResponder()
  }
  
  private func prepareCollectionView() {
    self.searchCollectionView.register(type: SearchCollectionViewCell.self)
    self.searchCollectionView.dataSource = self
    self.searchCollectionView.delegate = self
    
    let layout = FlowLayout(coloumnCount: 2)
    layout.scrollDirection = .vertical
    layout.minimumInteritemSpacing = LocalConstants.UIs.SearchCollectionView.space
    layout.minimumLineSpacing = LocalConstants.UIs.SearchCollectionView.space
    layout.sectionInset = LocalConstants.UIs.SearchCollectionView.edgeInsets
    layout.estimatedItemSize = LocalConstants.UIs.SearchCollectionView.estimatedItemSize
    self.searchCollectionView.contentInsetAdjustmentBehavior = .always
    self.searchCollectionView.collectionViewLayout = layout

  }
  
  // MARK: Actions
  @IBAction func wrapperTypeChangeAction(_ sender: Any) {
    let request = Search.Entities.Request(wrapperType: WrapperType.findCase(value: self.searchSegmentedControl.selectedSegmentIndex), query: self.searchBar.text ?? "")
    self.interactor?.didSearchEntities(request: request)
  }
  
}
                                      // MARK: - Extensions -

    // MARK: SearchDisplayLogic

extension SearchViewController : SearchDisplayLogic {

  func displayViewDidLoad(viewModel: Search.View.ViewModel) {
   
  }
  func displaySearchEntities(viewModel: Search.Entities.ViewModel) {
    self.searchEntities = viewModel.entities
    DispatchQueue.main.async {
      self.searchCollectionView.reloadData()
    }
    self.isLoadingMore = false
    
  }
  
  func displayError(viewModel: Search.Error.ViewModel) {
    self.showAlert(title: LocalConstants.Keys.errorTitle,
                   message: viewModel.message,
                   leftButton: LocalConstants.Keys.ok,
                   rightButton: nil) { } completionRight: { }
  }
}

    // MARK: UISearchBarDelegate
extension SearchViewController:UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.count > 2 {
      Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] _ in
        guard let self = self else { return }
        let request = Search.Entities.Request(wrapperType: WrapperType.findCase(value: self.searchSegmentedControl.selectedSegmentIndex), query: searchText)
        self.interactor?.didSearchEntities(request: request)
      }
    } else {
      self.searchEntities = []
      self.searchCollectionView.reloadData()
    }
  }

}
    // MARK: UICollectionViewDataSource & UICollectionViewDelegate
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.searchEntities.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let  cell = collectionView.dequeueReusableCell(ofType: SearchCollectionViewCell.self, at: indexPath)
    cell.configure(model: self.searchEntities[indexPath.row])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.router?.navigate(.toDetail(entity: self.searchEntities[indexPath.row]))
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let contentOffsetY = scrollView.contentOffset.y
    let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
    if (maximumOffset <= contentOffsetY) && !isLoadingMore {
      self.isLoadingMore = true
      self.interactor?.didLoadMoreEntities()
    }
  }
  
}
