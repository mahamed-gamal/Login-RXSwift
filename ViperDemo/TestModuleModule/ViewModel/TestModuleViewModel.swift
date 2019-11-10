//
//  TestModuleViewModel.swift
//  ViperDemo
//
//  Created Mohamed Gamal on 10/28/19.
//
//

import Foundation
import RxSwift
import RxCocoa
import Network

struct TestModuleViewModel {

    let emailMobile = BehaviorRelay<String?>(value: "")
    let password = BehaviorRelay<String?>(value: "")
    let loginTap = PublishSubject<Void>()
    
    let connectionErrorHandler = PublishSubject<NWPath>()
}
