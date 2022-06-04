//
//  SearchCollectionViewCell.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import UIKit
import Kingfisher

final class SearchCollectionViewCell: UICollectionViewCell, ViewModelType {
  
  @IBOutlet weak var bgView: UIView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var trackNameLabel: UILabel!
  @IBOutlet weak var collectionNameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
      let targetSize = CGSize(width: layoutAttributes.size.width, height: 0)
      layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
      return layoutAttributes
  }
  
  func configure(model: SearchEntity) {
    imageView.kf.setImage(with:model.artworkUrl100?.toURL(), placeholder: UIImage(named: "placeHolderYOK"))
    trackNameLabel.text = model.trackName
    collectionNameLabel.text = model.collectionName
    dateLabel.text = model.releaseDate?.appDateFormatted().0
    priceLabel.text = "$" + (model.collectionPrice?.toString() ?? "")
  }
}
