//
//  Main_Coordinator.swift
//  EYEPAX
//
//  Created by Nadeesha Chandrapala on 2022-05-31.
//  Copyright © 2022 Nadeesha Lakmal. All rights reserved.
//

import Foundation
import RxSwift

class MainCoordinator: BaseCoordinator<Void> {

    private let defaults                        = UserDefaults.standard
    var navigationController                    : UINavigationController!
    
    deinit {
        print("deinit MainCoordinator")
    }
    
    override func start() -> Observable<Void> {
        reStartApplication()

        return Observable.never()
    }
    
    func reStartApplication() {
        if UserAuth.si.signedIn && UserAuth.si.token != "" {
            goToRootVC()
        } else {
            goToSigninVC()
        }
    }
    
    private func goToSigninVC() {
        let viewController                      = SigninVC.initFromStoryboard(name: Storyboards.main.rawValue)
        let viewModel                           = SigninVM()
        viewController.viewModel                = viewModel
        navigationController                    = UINavigationController(rootViewController: viewController)
        
        disposeBag.insert([
            viewModel.showHomeVC.subscribe(onNext: { [weak self] (_) in
                self?.goToRootVC()
            }),
            
        ])
        window.rootViewController               = navigationController
        window.makeKeyAndVisible()
    }
    
    private func goToRootVC() {
        let rootVM                              = DashboardVM()
        disposeBag.insert([
            rootVM.showSignInVC.subscribe(onNext: { [weak self] (_) in
                let _ = self?.start()
            }),
            rootVM.showNewsDetail.subscribe(onNext: { [weak self] (article) in
                self?.goToNewsDetailsVC(article: article)
            }),
            rootVM.showSearchNewsPage.subscribe(onNext: { [weak self] (_) in
                self?.goToSearchNewsVC()
            }),
        ])

        let rootNavController                   = DashboardVC.initFromStoryboardEmbedInNVC(withViewModel: rootVM)
        self.navigationController               = rootNavController
        window.rootViewController               = navigationController
        window.makeKeyAndVisible()
    }
    
    private func goToNewsDetailsVC(article: Article) {
        let viewModel                           = NewsDetailVM(article: article)
        disposeBag.insert([
            viewModel.showSignInVC.subscribe(onNext: { [weak self] (_) in
                let _ = self?.start()
            }),
        ])

        let destinationVC               = NewsDetailVC.initFromStoryboard(name: Storyboards.main.rawValue, withViewModel: viewModel)
        self.navigationController.pushViewController(destinationVC, animated: true)
    }
    
    private func goToSearchNewsVC() {
        let viewModel                           = NewsSearchVM()
        disposeBag.insert([
            viewModel.showSignInVC.subscribe(onNext: { [weak self] (_) in
                let _ = self?.start()
            }),
            viewModel.doWithSelectedItem.subscribe(onNext: { [weak self] (article) in
                self?.goToNewsDetailsVC(article: article)
            }),
        ])

        let destinationVC               = NewsSearchVC.initFromStoryboard(name: Storyboards.main.rawValue, withViewModel: viewModel)
        self.navigationController.pushViewController(destinationVC, animated: true)
    }
    
}
