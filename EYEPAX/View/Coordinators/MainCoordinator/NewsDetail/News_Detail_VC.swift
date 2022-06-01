//
//  News_Detail_VC.swift
//  EYEPAX
//
//  Created by Nadeesha Chandrapala on 2022-06-01.
//  Copyright © 2022 Nadeesha Lakmal. All rights reserved.
//

import Foundation
import UIKit

class NewsDetailVC: BaseVC<NewsDetailVM> {
    
    @IBOutlet weak var imageVw: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    
    override func customiseView() {
        super.customiseView()
        imageVw.setImageWith(imagePath: viewModel?.article?.urlToImage ?? "", completion: nil)
        descLbl.text = viewModel?.article.description
    }
    
    override func setupBindings() {
        super.setupBindings()
        if let viewModel = self.viewModel {

            disposeBag.insert([
                // MARK: - Inputs
                viewModel.setupTitleViewInViewWillAppear.subscribe(onNext: { [weak self] _ in
                    self?.navigationController?.isNavigationBarHidden               = false
                    self?.title                                                     = viewModel.article.title
                }),
                // MARK: - Outputs
            ])
        }
    }
}
