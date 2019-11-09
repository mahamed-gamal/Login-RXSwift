//
//  RequestTokenService.swift
//  ViperDemo
//
//  Created by Mohamed Gamal on 11/4/19.
//  Copyright © 2019 ME. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol RequestTokenService {
    func requestToken(apiKey: String) -> Observable<RequestTokenResponse>
}

extension RequestTokenService {
    
    func requestToken(apiKey: String) -> Observable<RequestTokenResponse> {
        return Observable.create { observable -> Disposable in
            MoyaProvider<RequesttokenEndPoint>()
                .request(.requestToken(apiKey: apiKey)) { response in
    
        switch response {
        case .success(let response):
            if (response.statusCode >= 200 && response.statusCode <= 300){
                do {
                   let requestTokenResponse = try JSONDecoder().decode(RequestTokenResponse.self, from: response.data)
                   observable.onNext(requestTokenResponse)
                   observable.onCompleted()
                   
                   } catch let error {
                   //print("PARSING ERROR \(error)")
                   observable.onError(error)
                   }
            } else {
                print(response.statusCode.description)
            }

          case .failure(let error):
                //print("RESPONSE FAILURE \(error)")
                observable.onError(error)
            }
     }
            return Disposables.create()
    }
  }
}
