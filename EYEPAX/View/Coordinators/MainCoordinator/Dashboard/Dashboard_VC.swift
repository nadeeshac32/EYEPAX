//
//  Dashboard_VC.swift
//  EYEPAX
//
//  Created by Nadeesha Chandrapala on 2022-06-01.
//  Copyright © 2022 Nadeesha Lakmal. All rights reserved.
//

import Foundation
import UIKit

class DashboardVC: BaseVC<DashboardVM> {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var seeAllBtn: UIButton!
    @IBOutlet weak var _latestNewCV: UICollectionView!
    
    var latestNewCVViewModel    : LatestNewsCVVM?
    var latestNewCV             : LatestNewsCV<LatestNewCVCell>?
    
    override func customiseView() {
        super.customiseView()
        
    }
    
    override func setupBindings() {
        super.setupBindings()
        if let viewModel = self.viewModel {

            disposeBag.insert([
                // MARK: - Inputs
                viewModel.setupTitleViewInViewWillAppear.subscribe(onNext: { _ in
                    self.navigationController?.isNavigationBarHidden = true
                }),
                viewModel.setLatestNews.subscribe(onNext: { [weak self] (articles) in
                    self?.setLatestNews(latestNews: articles)
                }),
                // MARK: - Outputs
                seeAllBtn.rx.tap.subscribe({ (_) in
                    viewModel.showSearchNewsPage.onNext(true)
                }),
                
            ])
        }
    }
    
    func setLatestNews(latestNews: [Article]) {
        latestNewCVViewModel                    = LatestNewsCVVM(dataSource: self, latesNews: latestNews)
        if let latestNewCVViewModel = latestNewCVViewModel {
            self.latestNewCV                    = LatestNewsCV(viewModel: latestNewCVViewModel, collectionView: _latestNewCV, delegate: self)
            self._latestNewCV.showsHorizontalScrollIndicator          = false
            self._latestNewCV.bounces           = true
            self._latestNewCV.backgroundColor   = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            latestNewCV?.setupBindings()
        }
        latestNewCVViewModel?.doWithSelectedItem.subscribe(onNext: { [weak self] (article) in
            self?.viewModel?.showNewsDetail.onNext(article)
        }).disposed(by: disposeBag)
        latestNewCVViewModel?.viewDidLoad()
    }
        
}

extension DashboardVC: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        viewModel?.showSearchNewsPage.onNext(true)
        return false
    }
}

extension DashboardVC: BaseGridDelagate {
    func getCellLayout(_ collectionView: UICollectionView, shouldSetCellSize: Bool) -> UICollectionViewFlowLayout {
        let layout                              = UICollectionViewFlowLayout()
        layout.sectionInset                     = getLayoutInsets().sides
        layout.minimumLineSpacing               = getLayoutInsets().lineSpacing
        layout.minimumInteritemSpacing          = getLayoutInsets().interItemSpacing
        layout.scrollDirection                  = .horizontal
        
        if shouldSetCellSize {
            layout.itemSize                     = getItemSize(collectionView)
        } else {
            layout.estimatedItemSize            = getItemSize(collectionView)
        }
        
        return layout
    }
    
    func getItemSize(_ collectionView: UICollectionView) -> CGSize {
        return CGSize(width: 340, height: 240)
    }
    
    func getLayoutInsets() -> (columnsForRow: Int, sides: UIEdgeInsets, lineSpacing: CGFloat, interItemSpacing: CGFloat, widthToHeightPropotion: CGFloat) {
        return (columnsForRow: 0, sides: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8),
                lineSpacing: 8, interItemSpacing: 12, widthToHeightPropotion: 0)
    }
}

extension DashboardVC: BaseCollectionVMDataSource {
    func errorMessage<Model: BaseModel>(collectionVM: BaseCollectionVM<Model>, detail: SuccessMessageDetailType) {
            print("Handle error here. errorMessage errorMessage: ")
        }
        func successMessage<Model: BaseModel>(collectionVM: BaseCollectionVM<Model>, detail: SuccessMessageDetailType) {
        }
        func warningMessage<Model: BaseModel>(collectionVM: BaseCollectionVM<Model>, detail: SuccessMessageDetailType) {
        }
        func toastMessage<Model: BaseModel>(collectionVM: BaseCollectionVM<Model>, message: String) {
        }
        func requestLoading<Model: BaseModel>(collectionVM: BaseCollectionVM<Model>, isLoading: Bool) {
        }
        func showSignInVC<Model: BaseModel>(collectionVM: BaseCollectionVM<Model>) {
        }
}
