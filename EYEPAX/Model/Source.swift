//
//  Source.swift
//  EYEPAX
//
//  Created by Nadeesha Chandrapala on 2022-06-01.
//  Copyright © 2022 Nadeesha Lakmal. All rights reserved.
//

import Foundation
import ObjectMapper

class Source: BaseModel {
    var name: String?

    required init?(map: Map) {
        super.init(map: map)
    }

    override func mapping(map: Map) {
        id      <- map["id"]
        name    <- map["name"]
    }
}
