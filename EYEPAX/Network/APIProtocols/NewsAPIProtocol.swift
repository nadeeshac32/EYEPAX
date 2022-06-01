//
//  NewsAPIProtocol.swift
//  EYEPAX
//
//  Created by Nadeesha Chandrapala on 2022-06-01.
//  Copyright © 2022 Nadeesha Lakmal. All rights reserved.
//

import Alamofire

protocol NewsAPIProtocol {
    func getTopHeadlines(method: HTTPMethod!,
                         country: String!,
                         category: String?,
                         q: String?,
                         pageSize: Int!,
                         page: Int!,
                         onSuccess: ((_ articles: [Article], _ totalItemsCount: Int) -> Void)?,
                         onError: ErrorCallback?)
    
    func getEveryNews(method: HTTPMethod!,
                      q: String?,
                      pageSize: Int!,
                      page: Int!,
                      onSuccess: ((_ articles: [Article], _ totalItemsCount: Int) -> Void)?,
                      onError: ErrorCallback?)
}

extension HTTPService: NewsAPIProtocol {
    func getTopHeadlines(method: HTTPMethod! = .get,
                         country: String! = "us",
                         category: String? = nil,
                         q: String? = nil,
                         pageSize: Int! = 20,
                         page: Int! = 0,
                         onSuccess: (([Article], Int) -> Void)?,
                         onError: ErrorCallback?) {
        
        var contextPath = "top-headlines"
        contextPath += "?country=\(country!)"
        if category != nil { contextPath += "&category=\(category!)" }
        if q != nil { contextPath += "&q=\(q!)" }
        contextPath += "&pageSize=\(pageSize!)"
        contextPath += "&page=\(page!)"
        genericRequest(method: method!, parameters: nil, contextPath: contextPath, responseType: Article.self, onError: onError, completionHandlerForArray: { (arrayResponse, itemsCount) in
            onSuccess?(arrayResponse, itemsCount)
            return
        })
    }
    
    func getEveryNews(method: HTTPMethod! = .get,
                      q: String? = nil,
                      pageSize: Int! = 20,
                      page: Int! = 1,
                      onSuccess: (([Article], Int) -> Void)?,
                      onError: ErrorCallback?) {
        var contextPath = "everything"
        if q != nil {contextPath += "?q=\(q!)"}
        contextPath += "&pageSize=\(pageSize!)"
        contextPath += "&page=\(page!)"
        genericRequest(method: method!, parameters: nil, contextPath: contextPath, responseType: Article.self, onError: onError, completionHandlerForArray: { (arrayResponse, itemsCount) in
            onSuccess?(arrayResponse, itemsCount)
            return
        })
    }
    
}
