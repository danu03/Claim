//
//  Claim.swift
//  Claim
//
//  Created by Danu  on 16/7/25.
//

import Foundation

struct Claim: Identifiable, Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
