//
//  News_Search_VC.swift
//  EYEPAX
//
//  Created by Nadeesha Chandrapala on 2022-06-01.
//  Copyright © 2022 Nadeesha Lakmal. All rights reserved.
//

import Foundation
import UIKit

class NewsSearchVC: BaseListWithoutHeadersVC<Article, NewsSearchVM, NewsTVCell> {
    
    @IBOutlet weak var resultDescLbl            : UILabel!
    @IBOutlet weak var _tableView               : UITableView!
    
    override var cellLoadFromNib                : Bool { get { return true } set {} }
    override var shouldSetRowHeight             : Bool { get { return false } set {} }
    
    override func customiseView() {
        super.customiseView(tableView: _tableView, multiSelectable: false)
        self.searchBar.searchBarStyle           = .minimal
        resultDescLbl.text          = ""
        self.navigationController?.isNavigationBarHidden                        = false
        self.showSearchBar(searchBar: self.searchBar)
        self.addBackButton(title: nil)
    }
    
    override func setupBindings() {
        super.setupBindings()
        if let viewModel = self.viewModel {

            disposeBag.insert([
                // MARK: - Inputs
                viewModel.updateResultDesc.subscribe(onNext: { [weak self] (resultDesc) in
                    self?.resultDescLbl.text    = resultDesc
                }),
                // MARK: - Outputs
            ])
        }
    }
}
