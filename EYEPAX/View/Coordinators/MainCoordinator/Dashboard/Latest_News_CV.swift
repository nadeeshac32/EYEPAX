//
//  Latest_News_CV.swift
//  EYEPAX
//
//  Created by Nadeesha Chandrapala on 2022-06-01.
//  Copyright © 2022 Nadeesha Lakmal. All rights reserved.
//

import UIKit

class LatestNewsCV<CollectionViewCell: BaseCVCell<Article>>: BaseGridWithHeaders<Article, LatestNewsCVVM, CollectionViewCell, BaseCVSectionHeader> {
    deinit { print("deinit LatestNewsCV") }
    
    override var cellLoadFromNib: Bool { get { return true } set {} }
    override var showActivityIndicator: Bool { get { return true } set {} }
    override var scrollingEnableWhileItemsLoading: Bool { get { return true } set {} }
    
    override init(viewModel: LatestNewsCVVM, collectionView: UICollectionView!, delegate: BaseGridDelagate) {
        super.init(viewModel: viewModel, collectionView: collectionView, delegate: delegate)
        collectionView.backgroundColor      = .white
        collectionView.layer.cornerRadius   = 0
    }
}
