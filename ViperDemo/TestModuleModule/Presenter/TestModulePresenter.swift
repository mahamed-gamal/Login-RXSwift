//
//  TestModulePresenter.swift
//  ViperDemo
//
//  Created Mohamed Gamal on 10/28/19.
//
//

import UIKit
import RxSwift
import Network

class TestModulePresenter: TestModulePresenterProtocol {
    
    let monitor = NWPathMonitor()
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
        networkConnection()
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
    
    func networkConnection() {
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            self.viewModel.connectionErrorHandler.onNext(path)
        }
    }
}
