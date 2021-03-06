//
//  News_Detail_VM.swift
//  EYEPAX
//
//  Created by Nadeesha Chandrapala on 2022-06-01.
//  Copyright © 2022 Nadeesha Lakmal. All rights reserved.
//

import Foundation
import RxSwift

class NewsDetailVM: BaseVM {
    
    let article: Article!
    
    init(article: Article) {
        self.article = article
        super.init()
    }
}
