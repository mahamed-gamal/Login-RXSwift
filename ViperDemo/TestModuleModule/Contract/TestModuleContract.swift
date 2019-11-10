//
//  TestModuleContract.swift
//  ViperDemo
//
//  Created Mohamed Gamal on 10/28/19.
//
//

import Foundation
import RxSwift

enum TestModuleRoute {
}

protocol TestModuleRouterProtocol: class {
    func go(to route:TestModuleRoute)
}

protocol TestModulePresenterProtocol: class {
    func attach()
    var viewModel: TestModuleViewModel  { get }
}

protocol TestModuleInteractorProtocol: LoginService , RequestTokenService {

}

protocol TestModuleViewControllerProtocol: class {
  var presenter: TestModulePresenterProtocol?  { get set }
  //func loadIntent() -> Observable<Void>
}
