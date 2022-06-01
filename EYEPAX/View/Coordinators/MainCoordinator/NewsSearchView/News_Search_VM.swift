//
//  News_Search_VM.swift
//  EYEPAX
//
//  Created by Nadeesha Chandrapala on 2022-06-01.
//  Copyright © 2022 Nadeesha Lakmal. All rights reserved.
//

import Foundation
import RxSwift

class NewsSearchVM: BaseTableViewVM<Article> {
    
    override var dataLoadIn         : DataLoadIn? { get { return .ViewWillAppear } set {} }
    override var shouldSortFromKey  : Bool { get { return false } set {} }
    
    let updateResultDesc            = PublishSubject<String>()
    
    deinit {
        print("deinit NewsSearchVM")
    }
    
    // MARK: - Network request
    override func perfomrGetItemsRequest(loadPage: Int, limit: Int) {
        let httpService             = HTTPService()
        showSpiner()
        httpService.getTopHeadlines(pageSize: limit) { [weak self] (headlines, totalCount) in
            self?.requestLoading.onNext(false)
            self?.handleResponse(items: headlines, total: totalCount, page: loadPage)
            self?.updateResultDesc.onNext("About \(totalCount) results for Beaking News")
        } onError: { [weak self] error in
            self?.handleRestClientError(error: error)
        }
    }
    
    override func performSearchItemsRequest(searchText: String, loadPage: Int, limit: Int) {
        let httpService             = HTTPService()
        showSpiner()
        httpService.getEveryNews(q: searchText, pageSize: limit) { [weak self] (news, totalCount) in
            self?.requestLoading.onNext(false)
            self?.handleResponse(items: news, total: totalCount, page: loadPage)
            self?.updateResultDesc.onNext("About \(totalCount) results for \'\(searchText)\'")
        } onError: { [weak self] error in
            self?.handleRestClientError(error: error)
        }
    }
}
