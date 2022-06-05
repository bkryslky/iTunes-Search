//
//  DetailViewController.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import UIKit

protocol DetailDisplayLogic: AnyObject {
  func displayViewDidLoad(viewModel: Detail.View.ViewModel)
  func displayError(viewModel: Detail.Error.ViewModel)
}

class DetailViewController: UIViewController {
  // MARK: Outlets
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var trackNameLabel: UILabel!
  @IBOutlet weak var collectionNameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  // MARK: Variables
  var interactor: DetailBusinessLogic?
  var router: (NSObjectProtocol & DetailRoutingLogic & DetailDataPassing)?
  struct LocalConstants {
    struct Keys {
      static let ok = "Okay"
      static let errorTitle = "Something went wrong!"
    }
    struct UIs {
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
    let interactor = DetailInteractor()
    let presenter = DetailPresenter()
    let router = DetailRouter()
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
    self.interactor?.viewDidLoad()
  }
  // MARK: Actions
  @IBAction func close(_ sender: Any) {
      self.dismiss(animated:true)
  }
}

extension DetailViewController: DetailDisplayLogic {
  func displayViewDidLoad(viewModel: Detail.View.ViewModel) {
    self.imageView.kf.setImage(with:viewModel.searchEntity.artworkUrl100?.toURL(),
                               placeholder: UIImage(named: "placeHolder"))
    self.trackNameLabel.text = viewModel.searchEntity.trackName
    self.collectionNameLabel.text = viewModel.searchEntity.collectionName
    self.dateLabel.text = viewModel.searchEntity.releaseDate?.appDateFormatted().0
    self.priceLabel.text = "$" + (viewModel.searchEntity.collectionPrice?.toString() ?? "")
  }
  func displayError(viewModel: Detail.Error.ViewModel) {
    self.showAlert(title: LocalConstants.Keys.errorTitle,
                   message: viewModel.message,
                   leftButton: LocalConstants.Keys.ok,
                   rightButton: nil) { [weak self] in
      self?.dismiss(animated: true)
    } completionRight: { }
  }
}
