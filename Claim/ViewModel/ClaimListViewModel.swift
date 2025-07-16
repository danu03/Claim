//
//  ClaimListViewModel.swift
//  Claim
//
//  Created by Danu  on 16/7/25.
//

import Foundation

@MainActor
class ClaimListViewModel: ObservableObject {
    @Published var claims: [Claim] = []
    @Published var filteredClaims: [Claim] = []
    @Published var isLoading = false
    @Published var searchText = "" {
        didSet {
            filterClaims()
        }
    }
    
    @Published var showError = false
    @Published var errorMessage = ""

    private let service: ClaimServiceProtocol

    init(service: ClaimServiceProtocol = ClaimService()) {
        self.service = service
    }

    func fetchClaims() async {
        isLoading = true
        errorMessage = ""
        do {
            let result = try await service.fetchClaims()
            claims = result
            filteredClaims = result
        } catch {
            errorMessage = "Failed to fetch claims: \(error.localizedDescription)"
        }
        isLoading = false
    }

    private func filterClaims() {
        guard !searchText.isEmpty else {
            filteredClaims = claims
            return
        }

        filteredClaims = claims.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.body.localizedCaseInsensitiveContains(searchText)
        }
    }
}
