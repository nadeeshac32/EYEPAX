//
//  Article.swift
//  EYEPAX
//
//  Created by Nadeesha Chandrapala on 2022-06-01.
//  Copyright © 2022 Nadeesha Lakmal. All rights reserved.
//

import Foundation
import ObjectMapper

class Article: BaseModel {
    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    
    required init?(map: Map) {
        super.init(map: map)
    }

    override func mapping(map: Map) {
        id          = UUID().uuidString
        source      <- map["source"]
        author      <- map["author"]
        title       <- map["title"]
        description <- map["description"]
        url         <- map["url"]
        urlToImage  <- map["urlToImage"]
        publishedAt <- map["publishedAt"]
        content     <- map["content"]
    }
}
