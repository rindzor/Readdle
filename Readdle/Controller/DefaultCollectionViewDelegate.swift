//
//  DefaultCollectionViewDelegate.swift
//  CustomCollectionLayout
//
//  Created by Vladimir Drozdin on 25/05/20.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import UIKit

protocol CollectionViewSelectableItemDelegate: class, UICollectionViewDelegateFlowLayout {
    var didSelectItem: ((_ indexPath: IndexPath) -> Void)? {  get set  }
}

class DefaultCollectionViewDelegate: NSObject, CollectionViewSelectableItemDelegate {
    var didSelectItem: ((_ indexPath: IndexPath) -> Void)?
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

}
