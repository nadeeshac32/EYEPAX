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
                         category: String!,
                         sources: String!,
                         q: String!,
                         pageSize: Int!,
                         page: Int!,
                         onSuccess: ((_ articles: [Article], _ totalItemsCount: Int) -> Void)?,
                         onError: ErrorCallback?)
    
    func getEveryNews(method: HTTPMethod!,
                      q: String!,
                      qInTitle: String!,
                      sources: String!,
                      domains: String!,
                      excludeDomains: String!,
                      from: String!,
                      to: String!,
                      language: String!,
                      sortBy: String!,
                      pageSize: Int!,
                      page: Int!,
                      onSuccess: ((_ articles: [Article], _ totalItemsCount: Int) -> Void)?,
                      onError: ErrorCallback?)
}

extension HTTPService: NewsAPIProtocol {
    func getTopHeadlines(method: HTTPMethod! = .get,
                         country: String! = "",
                         category: String! = "",
                         sources: String! = "",
                         q: String! = "",
                         pageSize: Int! = 20,
                         page: Int! = 0,
                         onSuccess: (([Article], Int) -> Void)?,
                         onError: ErrorCallback?) {
        
        var contextPath = "top-headlines"
        contextPath += "?country=\(country!)"
        contextPath += "&category=\(category!)"
        contextPath += "&sources=\(sources!)"
        contextPath += "&q=\(q!)"
        contextPath += "&pageSize=\(pageSize!)"
        contextPath += "&page=\(page!)"
        genericRequest(method: method!, parameters: nil, contextPath: contextPath, responseType: Article.self, onError: onError, completionHandlerForArray: { (arrayResponse, itemsCount) in
            onSuccess?(arrayResponse, itemsCount)
            return
        })
    }
    
    func getEveryNews(method: HTTPMethod! = .get,
                      q: String! = "",
                      qInTitle: String! = "",
                      sources: String! = "",
                      domains: String! = "",
                      excludeDomains: String! = "",
                      from: String! = "",
                      to: String! = "",
                      language: String! = "",
                      sortBy: String! = "",
                      pageSize: Int! = 20,
                      page: Int! = 1,
                      onSuccess: (([Article], Int) -> Void)?,
                      onError: ErrorCallback?) {
        
        var contextPath = "everything"
        contextPath += "?q=\(q!)"
        contextPath += "&qInTitle=\(qInTitle!)"
        contextPath += "&sources=\(sources!)"
        contextPath += "&domains=\(domains!)"
        contextPath += "&excludeDomains=\(excludeDomains!)"
        contextPath += "&from=\(from!)"
        contextPath += "&to=\(to!)"
        contextPath += "&language=\(language!)"
        contextPath += "&sortBy=\(sortBy!)"
        contextPath += "&pageSize=\(pageSize!)"
        contextPath += "&page=\(page!)"
        genericRequest(method: method!, parameters: nil, contextPath: contextPath, responseType: Article.self, onError: onError, completionHandlerForArray: { (arrayResponse, itemsCount) in
            onSuccess?(arrayResponse, itemsCount)
            return
        })
    }
    
}
