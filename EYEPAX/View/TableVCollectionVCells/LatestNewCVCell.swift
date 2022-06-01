//
//  LatestNewCVCell.swift
//  EYEPAX
//
//  Created by Nadeesha Chandrapala on 2022-06-01.
//  Copyright © 2022 Nadeesha Lakmal. All rights reserved.
//

import UIKit

class LatestNewCVCell: BaseCVCell<Article> {
    
    @IBOutlet weak var imageVw: UIImageView!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var headline: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor                    = .clear
        imageVw.layer.cornerRadius              = 5
        authorLbl.text                          = ""
        headline.text                           = ""
        descLbl.text                            = ""
    }
        
    override func configureCell(item: Article, section: Int, row: Int, selectable: Bool) {
        super.configureCell(item: item, section: section, row: row, selectable: selectable)
        if let imageUrl = item.urlToImage {
            self.imageVw.setImageWith(imagePath: imageUrl, completion: nil)
        } else {
            print("ContestantDetailCVCell imageUrl nil")
        }
        authorLbl.text                          = item.author
        headline.text                           = item.title
        descLbl.text                            = item.description
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageVw.image                           = nil
        authorLbl.text                          = ""
        headline.text                           = ""
        descLbl.text                            = ""
    }

}
