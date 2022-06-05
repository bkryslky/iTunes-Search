//
//  FlowLayout.swift
//  iTunesSearch
//
//  Created by Guest on 4.06.2022.
//

import Foundation
import UIKit

class FlowLayout : UICollectionViewFlowLayout {
  // MARK: Variables
  private var coloumnCount:Int = 2
  // MARK: Object Lifecycle
  init(coloumnCount: Int) {
    super.init()
    self.coloumnCount = coloumnCount
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK: Methods
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let layoutAttributesObjects = super.layoutAttributesForElements(in: rect)?
      .map { $0.copy() } as? [UICollectionViewLayoutAttributes]
    layoutAttributesObjects?.forEach({ layoutAttributes in
      if layoutAttributes.representedElementCategory == .cell {
        if let newFrame = layoutAttributesForItem(at: layoutAttributes.indexPath)?.frame {
          layoutAttributes.frame = newFrame
        }
      }
    })
    return layoutAttributesObjects
  }
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    guard let collectionView = collectionView else { fatalError() }
    guard let layoutAttributes = super.layoutAttributesForItem(at: indexPath)?
            .copy() as? UICollectionViewLayoutAttributes else {
      return nil
    }
    layoutAttributes.frame.size.width = (
      (collectionView.safeAreaLayoutGuide.layoutFrame.width
       - ((self.minimumInteritemSpacing*CGFloat(coloumnCount-1))
          + (self.sectionInset.left + self.sectionInset.right))) / CGFloat(coloumnCount))
    return layoutAttributes
  }
  override func shouldInvalidateLayout(
    forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes,
    withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
    return true
  }
}
