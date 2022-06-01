//
//  News_Search_VC.swift
//  EYEPAX
//
//  Created by Nadeesha Chandrapala on 2022-06-01.
//  Copyright © 2022 Nadeesha Lakmal. All rights reserved.
//

import Foundation
import UIKit

class NewsSearchVC: BaseVC<NewsSearchVM> {
    
    override func setupBindings() {
        super.setupBindings()
        if let viewModel = self.viewModel {

            disposeBag.insert([
                // MARK: - Inputs
                viewModel.setupTitleViewInViewWillAppear.subscribe(onNext: { _ in
                    self.navigationController?.isNavigationBarHidden = true
                }),
                // MARK: - Outputs
            ])
        }
    }
}
