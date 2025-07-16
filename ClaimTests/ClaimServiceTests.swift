//
//  ClaimServiceTest.swift
//  ClaimTests
//
//  Created by Danu  on 16/7/25.
//

import XCTest
@testable import Claim

final class ClaimServiceTests: XCTestCase {

    func testFetchClaimsReturnsResults() async throws {
        let service = ClaimService()
        let claims = try await service.fetchClaims()

        XCTAssertFalse(claims.isEmpty)
        XCTAssertNotNil(claims.first)
    }
}
