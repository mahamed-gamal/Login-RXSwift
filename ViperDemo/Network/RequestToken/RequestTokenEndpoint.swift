//
//  RequestTokenEndpoint.swift
//  ViperDemo
//
//  Created by Mohamed Gamal on 11/4/19.
//  Copyright © 2019 ME. All rights reserved.
//

import Foundation
import Moya
import RxSwift

enum RequesttokenEndPoint {
    case requestToken (apiKey: String)
}

extension RequesttokenEndPoint: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org")!
    }
    
    var path: String {
        return "/3/authentication/token/new"
    }
    
    var method: Moya.Method {
        .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
            
        case .requestToken(let apiKey):
            return .requestParameters(parameters: ["api_key": apiKey], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
