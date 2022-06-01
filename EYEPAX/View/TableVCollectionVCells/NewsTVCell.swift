//
//  NewsTVCell.swift
//  EYEPAX
//
//  Created by Nadeesha Chandrapala on 2022-06-02.
//  Copyright © 2022 Nadeesha Lakmal. All rights reserved.
//

import UIKit

class NewsTVCell: BaseTVCell<Article> {
    
    @IBOutlet weak var imageVw          : UIImageView!
    @IBOutlet weak var titleLbl         : UILabel!
    @IBOutlet weak var descLbl          : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle             = .none
        self.backgroundColor            = .white
        self.imageVw.contentMode        = .scaleAspectFill
        self.imageVw.layer.cornerRadius = 5
        self.titleLbl.text              = ""
        self.descLbl.text               = ""
        self.descLbl.numberOfLines      = 2
        
    }
    
    override func configureCell(item: Article, row: Int, selectable: Bool) {
        super.configureCell(item: item, row: row, selectable: selectable)
        imageVw.setImageWith(imagePath: item.urlToImage ?? "", completion: nil)
        titleLbl.text                   = item.title ?? ""
        descLbl.text                    = item.author ?? ""
    }
    
    override func prepareForReuse() {
        imageVw.image                   = nil
        titleLbl.text                   = ""
        descLbl.text                    = ""
    }
    
}
