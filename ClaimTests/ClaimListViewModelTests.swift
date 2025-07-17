//
//  ClaimListViewModelTests.swift
//  ClaimTests
//
//  Created by Danu  on 16/7/25.
//

import XCTest
@testable import Claim

class MockClaimService: ClaimServiceProtocol {
    func fetchUser() async throws -> [Users] {
        return [Users(id: 1, name: "Name")]
    }
    
    func fetchClaims() async throws -> [Claim] {
        return [Claim(userId: 1, id: 1, title: "Test Title", body: "Test body")]
    }
}

final class ClaimListViewModelTests: XCTestCase {

    func testFetchClaimsSuccess() async {
        let viewModel = await ClaimListViewModel(service: MockClaimService())
        await viewModel.fetchClaims()

        let claimCount = await MainActor.run { viewModel.claims.count }
        let claimTittle = await MainActor.run { viewModel.claims.first?.title }
        XCTAssertEqual(claimCount, 1)
        XCTAssertEqual(claimTittle, "Test Title")
    }

    func testSearchFilter() async {
        let viewModel = await ClaimListViewModel(service: MockClaimService())
        await viewModel.fetchClaims()

        await MainActor.run { viewModel.searchText = "Title" }
        let filteredClaim = await MainActor.run { viewModel.filteredClaims.count }
        XCTAssertEqual(filteredClaim, 1)

        await MainActor.run { viewModel.searchText = "xyz" }
        let filteredClaimZero = await MainActor.run { viewModel.filteredClaims.count }
        XCTAssertEqual(filteredClaimZero, 0)
    }
}
