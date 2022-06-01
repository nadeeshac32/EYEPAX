//
//  NCManuTabCell_BiggerText.swift
//  Base Project
//
//  Created by Nadeesha Chandrapala on 10/21/20.
//  Copyright © 2020 Nadeesha Lakmal. All rights reserved.
//

import Foundation
import UIKit

class NCManuTabCell_BiggerText: NCManuTabCell {
    override func updateTitle() {
        self.titleLabel.textColor                   = self.isSelected == true ? self.highLighterColor : self.titleColor
        self.titleLabel.font                        = self.isSelected == true ? MainFont.medium.with(size: 18) : MainFont.medium.with(size: 16)
    }
}
