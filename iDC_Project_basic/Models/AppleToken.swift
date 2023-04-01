//
//  AppleToken.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/04/01.
//

import Foundation

struct AppleTokenResponse: Codable {
    let refreshToken: String?
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}
