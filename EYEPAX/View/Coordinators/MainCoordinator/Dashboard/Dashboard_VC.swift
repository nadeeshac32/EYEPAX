//
//  Dashboard_VC.swift
//  EYEPAX
//
//  Created by Nadeesha Chandrapala on 2022-06-01.
//  Copyright © 2022 Nadeesha Lakmal. All rights reserved.
//

import Foundation
import UIKit

class DashboardVC: BaseListWithoutHeadersVC<Article, DashboardVM, NewsTVCell>, BaseMenuTabProtocol {
    
    @IBOutlet weak var logOutBtn    : UIButton!
    @IBOutlet weak var _searchBar   : UISearchBar!
    @IBOutlet weak var seeAllBtn    : UIButton!
    @IBOutlet weak var _menuBarView : UIView!
    @IBOutlet weak var _latestNewCV : UICollectionView!
    @IBOutlet weak var _tableView   : UITableView!
    
    override var cellLoadFromNib    : Bool { get { return true } set {} }
    override var shouldSetRowHeight : Bool { get { return false } set {} }
    
    var latestNewCVViewModel        : LatestNewsCVVM?
    var latestNewCV                 : LatestNewsCV<LatestNewCVCell>?
    
    var tabIndex                    = 0
    var currentIndex                = 0
    var menuBarView                 : NCManuTab<NCManuTabCell_Circle>!
    
    override func customiseView() {
        super.customiseView(tableView: _tableView, multiSelectable: false)
        logOutBtn.setTitle("", for: .normal)
        logOutBtn.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        _searchBar.delegate         = self
        
        updateTabView()
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
                    self?.updateLatestNews(latestNews: articles)
                }),
                // MARK: - Outputs
                logOutBtn.rx.tap.bind {
                    viewModel.logoutUser()
                },
                seeAllBtn.rx.tap.subscribe({ (_) in
                    viewModel.showSearchNewsPage.onNext(true)
                }),
            ])
        }
    }
    
    func updateLatestNews(latestNews: [Article]) {
        latestNewCVViewModel                        = LatestNewsCVVM(dataSource: self, latesNews: latestNews)
        if let latestNewCVViewModel = latestNewCVViewModel {
            self.latestNewCV                        = LatestNewsCV(viewModel: latestNewCVViewModel, collectionView: _latestNewCV, delegate: self)
            self._latestNewCV.showsHorizontalScrollIndicator          = false
            self._latestNewCV.bounces               = true
            self._latestNewCV.backgroundColor       = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            latestNewCV?.setupBindings()
        }
        latestNewCVViewModel?.doWithSelectedItem.subscribe(onNext: { [weak self] (article) in
            self?.viewModel?.showNewsDetail.onNext(article)
        }).disposed(by: disposeBag)
        latestNewCVViewModel?.viewDidLoad()
    }
    
    func updateTabView() {
        self.menuBarView                            = NCManuTab<NCManuTabCell_Circle>(frame: CGRect(x: 0, y: 0, width: _menuBarView.frame.width, height: _menuBarView.frame.height))
        self._menuBarView.addSubview(self.menuBarView)
        self._menuBarView.addConstraintsWithFormatString(formate: "V:|[v0]|", views: menuBarView)
        self._menuBarView.addConstraintsWithFormatString(formate: "H:|[v0]|", views: menuBarView)
        
        self.menuBarView.menuDelegate               = self
        self.menuBarView.isSizeToFitCellsNeeded     = true
        self.menuBarView.collView.backgroundColor   = UIColor.clear
        
        let tabs = viewModel?.categoriesList.map { MenuTabCellAttributes(title: $0, titleColor: .black, highLighter: AppConfig.si.colorPrimary) } ?? []
        self.menuBarView.dataArray                  = tabs
        self.menuBarView.collView.selectItem(at: IndexPath.init(item: 0, section: 0), animated: true, scrollPosition: .centeredVertically)
    }
    
    override func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
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

extension DashboardVC: MenuBarDelegate {

    func menuBarDidSelectItemAt(index: Int) {
        // If selected Index is not the selected Selected one, by comparing with current index, page controller goes either forward or backward.
        if index != currentIndex {
            currentIndex        = index
            menuBarView.collView.scrollToItem(at: IndexPath.init(item: index, section: 0), at: .centeredHorizontally, animated: true)
            viewModel?.category = viewModel?.categoriesList[index] ?? ""
        }
    }
    
}
