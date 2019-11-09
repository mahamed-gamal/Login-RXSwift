//
//  LoginService.swift
//  ViperDemo
//
//  Created by Mohamed Gamal on 11/4/19.
//  Copyright © 2019 ME. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol LoginService {
    func login(email: String, password: String , token: String , apiKey: String) -> Observable<LoginResponse>
}

extension LoginService {
    
    func login(email: String, password: String , token: String , apiKey: String) -> Observable<LoginResponse> {
        return Observable.create { observable -> Disposable in
            MoyaProvider<LoginEndPoint>()
                .request(.login(email: email, password: password, token: token, apikey: apiKey)) { response in
                switch response {
                    case .success(let response):
                    do {
                    let statusCode = try response.filterSuccessfulStatusCodes()
                    print(statusCode)
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: response.data)
                        observable.onNext(loginResponse)
                        observable.onCompleted()
                        
                    } catch let error {
                    //print("PARSING ERROR \(error)")
                        observable.onError(error)
                    }
                    case .failure(let error):
                        print("Response Failure \(String(describing: error.errorDescription))")
                    //print("RESPONSE FAILURE \(error)")
                        observable.onError(error)

                }
            }
            return Disposables.create()
        }
   
    }
}

