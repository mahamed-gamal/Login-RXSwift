//
//  LoginEndpoint.swift
//  ViperDemo
//
//  Created by Mohamed Gamal on 11/4/19.
//  Copyright © 2019 ME. All rights reserved.
//

import Moya
import RxSwift

enum LoginEndPoint {
    case login(email: String , password: String , token: String , apikey: String)
}

 //https://api.themoviedb.org/3/authentication/token/validate_with_login?
extension LoginEndPoint: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org")!
    }
    
    var path: String {
        return "/3/authentication/token/validate_with_login"
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .login(let email , let password , let token , let apiKey):
            let bodyParameters:[String : String] = ["username": email , "password": password , "request_token": token ]
            return .requestCompositeParameters(bodyParameters: bodyParameters,
                                               bodyEncoding: JSONEncoding.default, urlParameters: ["api_key": apiKey])

        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/json"]
    }
    
}
