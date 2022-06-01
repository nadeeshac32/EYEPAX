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
    @IBOutlet weak var logoutBtn                : UIButton!
    
    override func customiseView() {
        logoutBtn.layer.cornerRadius            = 3
    }
    
    override func setupBindings() {
        super.setupBindings()
        if let viewModel = self.viewModel {

            disposeBag.insert([
                // MARK: - Inputs
                
                // MARK: - Outputs
                logoutBtn.rx.tap.bind {
                    viewModel.logoutUser()
                }
            ])
        }
    }
}
