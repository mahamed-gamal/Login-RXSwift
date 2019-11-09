//
//  TestModulePresenter.swift
//  ViperDemo
//
//  Created Mohamed Gamal on 10/28/19.
//
//

import UIKit
import RxSwift

class TestModulePresenter: TestModulePresenterProtocol {
    
    weak private var viewController: TestModuleViewControllerProtocol?
    var interactor: TestModuleInteractorProtocol?
    private let router: TestModuleRouterProtocol
    private let disposeBag = DisposeBag()
    var viewModel =  TestModuleViewModel()  

    init(viewController: TestModuleViewControllerProtocol, interactor: TestModuleInteractorProtocol?, router: TestModuleRouterProtocol) {
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
        }
    
    func attach() {
        handleLoginButtonTap()
        handleInternetConnection()
    }
    
    private func handleLoginButtonTap() {
        viewModel.loginTap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.interactor?.requestToken(apiKey: StaticApiKey.apiKey.rawValue).subscribe(onNext: { response in
                print("Response: \(response)")
                self.loginWithToken(token: response.requestToken ?? "")
            }, onError: { error in
                print("ERROR: \(error)")
            }).disposed(by: self.disposeBag)
        }).disposed(by: self.disposeBag)
    }
    
    func loginWithToken(token: String) {
        let email = self.viewModel.emailMobile.value ?? ""
        let password = self.viewModel.password.value ?? ""
        interactor?.login(email: email, password: password, token: token , apiKey: StaticApiKey.apiKey.rawValue).subscribe(onNext: { response in
            print("Response \(response)")
        }).disposed(by: self.disposeBag)
    }
    
    func handleInternetConnection() {
        interactor?.isReachable.subscribe(onNext: { [weak self] connected in
            self?.viewModel.connectionErrorHandler.accept(connected)
        }).disposed(by: disposeBag)
    }
    
}
