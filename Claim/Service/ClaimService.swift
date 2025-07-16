//
//  ClaimService.swift
//  Claim
//
//  Created by Danu  on 16/7/25.
//

import Foundation

protocol ClaimServiceProtocol {
    func fetchClaims() async throws -> [Claim]
}

class ClaimService: ClaimServiceProtocol {
    func fetchClaims() async throws -> [Claim] {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode([Claim].self, from: data)
    }
}
