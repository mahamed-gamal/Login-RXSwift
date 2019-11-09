//
//  LoginEntity.swift
//  ViperDemo
//
//  Created by Mohamed Gamal on 11/5/19.
//  Copyright © 2019 ME. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    let success: Bool?
    let expiresAt: String?
    let requestToken: String?
    
    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
