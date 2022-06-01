//
//  GeneralArrayResponse.swift
//  Base Project
//
//  Created by Nadeesha Chandrapala on 9/8/20.
//  Copyright © 2020 Nadeesha Lakmal. All rights reserved.
//

import ObjectMapper

class GeneralArrayResponse<DataType: BaseModel>: BaseModel {
    var status              : String?
    var data                : [DataType]?
    var totalResults        : Int?
    
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        status              <- map["status"]
        data                <- map[DataType.arrayKey]
        totalResults        <- map["totalResults"]
    }
}
