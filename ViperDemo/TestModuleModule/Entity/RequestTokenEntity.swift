//
//  RequestTokenEntity.swift
//  ViperDemo
//
//  Created by Mohamed Gamal on 11/4/19.
//  Copyright © 2019 ME. All rights reserved.
//

import Foundation

struct RequestTokenResponse: Codable {
    
    let success: Bool?
    let expiresAt: String?
    let requestToken: String?
    
    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}

//connection and internet errors
//check internet reachability before sending requests
//catch connection errors if network was down while waiting for response

//handle http errors,other than 200...300
//parsing erorrs, validate the data schema
//after reciving the request make sure the data is valid
