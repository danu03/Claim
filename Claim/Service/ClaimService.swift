//
//  ClaimService.swift
//  Claim
//
//  Created by Danu  on 16/7/25.
//

import Foundation
import Alamofire

protocol ClaimServiceProtocol {
    func fetchClaims() async throws -> [Claim]
    func fetchUser() async throws -> [Users]
}

class ClaimService: ClaimServiceProtocol {
    func fetchClaims() async throws -> [Claim] {
        let url = "https://jsonplaceholder.typicode.com/posts"

        let response = await AF.request(url)
            .validate(statusCode: 200..<300)
            .serializingDecodable([Claim].self)
            .response

        switch response.result {
        case .success(let claims):
            return claims
        case .failure(let error):
            throw error
        }
    }
    
    func fetchUser() async throws -> [Users] {
        let url = "https://jsonplaceholder.typicode.com/users"
        
        let response = await AF.request(url)
            .validate(statusCode: 200..<300)
            .serializingDecodable([Users].self)
            .response
        
        switch response.result {
        case .success(let users):
            return users
        case .failure(let error):
            throw error
        }
    }
}
