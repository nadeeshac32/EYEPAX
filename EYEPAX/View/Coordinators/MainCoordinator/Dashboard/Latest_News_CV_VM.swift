//
//  Latest_News_CV_VM.swift
//  EYEPAX
//
//  Created by Nadeesha Chandrapala on 2022-06-01.
//  Copyright © 2022 Nadeesha Lakmal. All rights reserved.
//

/// If you initialise a instance of this class in side another BaseVM instance you should add newly created instance to the parent BaseVM's childViewModels array.
class LatestNewsCVVM: BaseCollectionVM<Article> {
    
    override var dataLoadIn             : DataLoadIn? { get { return .StopAutoLoading } set {} }
    
    var isInitialContentsSet            : Bool = false
    let latesNews                       : [Article]
    
    deinit { print("deinit LatestNewsCVVM") }
    
    init(dataSource: BaseCollectionVMDataSource?, latesNews: [Article]) {
        self.latesNews                  = latesNews
        super.init(dataSource: dataSource)
    }
    
    override func viewDidLoad() {
        if isInitialContentsSet == false {
            self.handleResponse(items: latesNews, total: 0, page: 0, hasNextPage: false, loadInGridWithHeadersButWithoutHeaders: true)
            self.requestLoading.onNext(false)
            self.isInitialContentsSet   = true
        }
        super.viewDidLoad()
    }
    
}
