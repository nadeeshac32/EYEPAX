//
//  Dashboard_VM.swift
//  EYEPAX
//
//  Created by Nadeesha Chandrapala on 2022-06-01.
//  Copyright © 2022 Nadeesha Lakmal. All rights reserved.
//

import Foundation
import RxSwift

class DashboardVM: BaseVM {
    
    let setLatestNews                   = PublishSubject<[Article]>()
    let showSearchNewsPage              = PublishSubject<Bool>()
    let showNewsDetail                  = PublishSubject<Article>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLatestNewsRequest()
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
