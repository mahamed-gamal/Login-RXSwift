//
//  TestModuleRouter.swift
//  ViperDemo
//
//  Created Mohamed Gamal on 10/28/19.
//
//

import UIKit

class TestModuleRouter: TestModuleRouterProtocol {
    
    //MARK:- Attributes
    weak var viewController: UIViewController?
    
    //MARK:- Assemple
    static func assembleModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = TestModuleViewController()
        let interactor = TestModuleInteractor()
        let router = TestModuleRouter()
        let presenter = TestModulePresenter(viewController: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    //MARK:- Routing
    func go(to route:TestModuleRoute) {
        switch route {
        default:
            break
        }
    }

}
