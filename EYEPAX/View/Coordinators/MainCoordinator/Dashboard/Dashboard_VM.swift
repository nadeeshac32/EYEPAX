//
//  Dashboard_VM.swift
//  EYEPAX
//
//  Created by Nadeesha Chandrapala on 2022-06-01.
//  Copyright © 2022 Nadeesha Lakmal. All rights reserved.
//

import Foundation
import RxSwift

class DashboardVM: BaseTableViewVM<Article> {
    
    override var dataLoadIn         : DataLoadIn? { get { return .ViewWillAppear } set {} }
    override var shouldSortFromKey  : Bool { get { return false } set {} }
    
    let setLatestNews                   = PublishSubject<[Article]>()
    let showSearchNewsPage              = PublishSubject<Bool>()
    let showNewsDetail                  = PublishSubject<Article>()
    
    var category: String = "business" {
        didSet {
            reloadList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLatestNewsRequest()
    }
    
    // MARK: - Network request
    override func perfomrGetItemsRequest(loadPage: Int, limit: Int) {
        let httpService             = HTTPService()
        showSpiner()
        httpService.getEveryNews(q: category, pageSize: limit) { [weak self] (news, totalCount) in
            self?.requestLoading.onNext(false)
            self?.handleResponse(items: news, total: totalCount, page: loadPage)
        } onError: { [weak self] error in
            self?.handleRestClientError(error: error)
        }
    }
    
    private func getLatestNewsRequest() {
        let httpService           = HTTPService()
        requestLoading.onNext(true)
        httpService.getTopHeadlines(onSuccess: { [weak self] (articles, totalItemsCount) in
            self?.requestLoading.onNext(false)
            self?.setLatestNews.onNext(articles)
        }) { [weak self] (error) in
            self?.handleRestClientError(error: error)
        }
    }
    
}
